import { deleted, notFound, publish } from "@shared/constants";
import { StatusCodes } from "http-status-codes";
import { Includeable, Op, QueryTypes, Sequelize, Transaction } from "sequelize";
import HttpError from "@helper/iHttpError";
import Blog, { BlogAttributes, BlogInstance, BlogCreationAttributes } from "@src/models/Blog";
import Category, { CategoryInstance } from "@src/models/Category";
import Tag, { TagInstance } from "@src/models/Tag";
import MediaDao from "@daos/Media/MediaDao";
import CategoryDao from "@daos/Category/Category";
import Media from "@src/models/Media";
import Product, { ProductInstance } from "@src/models/Product";
import { sequelize } from "@src/models";
import Subscribe from "@src/models/Subscribe";
import sendMailBlog from "@helper/mailService/sendMailBlog";

const checkDelete = { status: { [Op.not]: deleted } };

const mediaDao = new MediaDao();
const categoryDao = new CategoryDao();

class BlogDao {
  public async create(data: BlogCreationAttributes): Promise<BlogInstance> {
    let listCategory: CategoryInstance[] = [];
    let listTag: TagInstance[] = [];
    let file = null;

    if (data.category) {
      listCategory = await Category.findAll({
        where: {
          id: {
            [Op.in]: [...data.category],
          },
        },
      });
    }

    if (data.tag) {
      listTag = await Tag.findAll({
        where: {
          id: {
            [Op.in]: [...data.tag],
          },
        },
      });
    }

    if (data.feature_image) {
      file = await mediaDao.find(data.feature_image);
    }

    if (
      (listTag.length != data.tag?.length && data.tag) ||
      (listCategory.length != data.category?.length && data.category) ||
      (data.feature_image && !file)
    )
      throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    const blog = await Blog.create({
      ...data,
      feature_image: file?.filename,
    });
    await blog.addTag([...listTag]);
    await blog.addCategory([...listCategory]);

    const result = await this.find(blog.path);

    return result;
  }

  public async edit(
    query: string,
    data: BlogAttributes
  ): Promise<BlogInstance> {
    try {
      const result = await sequelize.transaction(async (t) => {
        let file = null;
        const blog = await Blog.findOne({
          where: {
            ...checkDelete,
            [Op.or]: [{ id: query }, { path: query }],
          },
        });

        if (data.feature_image) {
          file = await Media.findOne({
            where: { filename: data.feature_image },
          });
        }

        if ((data.feature_image && !file) || !blog)
          throw new HttpError(StatusCodes.NOT_FOUND, notFound);
        if (data.category) {
          await this.updateCategory(query, data.category, t);
        }
        if (data.tag) {
          await this.updateTag(query, data.tag, t);
        }
        if (data.product) {
          await this.updateRelateProduct(query, data.product, t);
        }

        await blog.update(
          {
            ...data,
            feature_image: file?.filename ?? data.feature_image,
          },
          { transaction: t }
        );
        return blog;
      });
      const res = await this.find(result.path);
      return res;
    } catch (err) {
      throw err;
    }
  }

  public async delete(query: string): Promise<void> {
    const blog = await Blog.findOne({
      where: {
        ...checkDelete,
        [Op.or]: [{ id: query }, { path: query }],
      },
    });
    if (blog == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    blog.setAttributes({
      status: deleted,
    });

    blog.save();
  }

  public async find(query: string): Promise<BlogInstance> {
    const blog = await Blog.scope([
      "withTag",
      "withCategory",
      "withProduct",
      "withMedia",
    ]).findOne({
      where: {
        ...checkDelete,
        [Op.or]: [{ id: query }, { path: query }],
      },
    });
    if (blog == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    return blog;
  }

  public async findPublic(query: string): Promise<BlogInstance> {
    const blog = await Blog.scope("public").findOne({
      where: {
        [Op.or]: [{ id: query }, { path: query }],
      },
    });
    if (blog == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    return blog;
  }

  public async search(
    query: string,
    categoryQuery?: any,
    tagQuery?: any,
    statusQuery?: any
  ): Promise<BlogInstance[]> {
    return Blog.scope(["withCategory", "withTag", "withMedia"]).findAll({
      where: {
        title: { [Op.like]: `%${query}%` },
        status: statusQuery ? statusQuery : { [Op.not]: deleted },
      },
      attributes: { exclude: ["content"] },
      order: [["createdAt", "DESC"]],
    });
  }

  public async updateCategory(
    query: string,
    listNew: number[],
    transaction: Transaction
  ): Promise<void> {
    const blog = await Blog.findOne({
      where: {
        ...checkDelete,
        [Op.or]: [{ id: query }, { path: query }],
      },
    });
    const currentCategory: CategoryInstance[] = await blog?.getCategory({
      attributes: ["id"],
    });
    let listToRemove: number[] = [];
    let listToAdd: number[] = [];
    let listCurrent: number[] = currentCategory.map((item) => Number(item.id));

    listToRemove = listCurrent.filter((item) => listNew.indexOf(item) < 0);
    listToAdd = listNew.filter(
      (item) => listToRemove.indexOf(item) < 0 && listCurrent.indexOf(item) < 0
    );

    await blog?.addCategory([...listToAdd], { transaction });
    await blog?.removeCategory([...listToRemove], { transaction });
  }

  public async updateTag(
    query: string,
    listNew: number[],
    transaction: Transaction
  ): Promise<void> {
    const blog = await Blog.findOne({
      where: {
        ...checkDelete,
        [Op.or]: [{ id: query }, { path: query }],
      },
    });
    const currentTag: TagInstance[] = await blog?.getTag({
      attributes: ["id"],
    });

    let listToRemove: number[] = [];
    let listToAdd: number[] = [];
    let listCurrent: number[] = currentTag.map((item) => Number(item.id));

    listToRemove = listCurrent.filter((item) => listNew.indexOf(item) < 0);
    listToAdd = listNew.filter(
      (item) => listToRemove.indexOf(item) < 0 && listCurrent.indexOf(item) < 0
    );

    await blog?.addTag([...listToAdd], { transaction });
    await blog?.removeTag([...listToRemove], { transaction });
  }

  public async getLastedBlog(limit: number): Promise<BlogInstance[]> {
    return Blog.scope("public").findAll({
      limit: limit,
      order: [["last_publish", "DESC"]],
    });
  }

  public async searchPublic(
    query: string,
    categoryQuery?: any,
    tagQuery?: any
  ): Promise<BlogInstance[]> {
    if (categoryQuery || tagQuery)
      return this.searchPublicByCategoryAndTag(query, categoryQuery, tagQuery);

    let result = await Blog.scope("public").findAll({
      where: {
        [Op.and]: [{ status: publish }, { title: { [Op.like]: `%${query}%` } }],
      },
      attributes: { exclude: ["content"] },
      order: [["last_publish", "DESC"]],
      include: [
        {
          model: Category.scope("public"),
          as: "category",
          through: { attributes: [] },
        },
        {
          model: Tag.scope("public"),
          as: "tag",
          through: { attributes: [] },
        },
      ],
    });

    return result;
  }

  public async searchPublicByCategoryAndTag(
    query: string,
    categoryQuery?: any,
    tagQuery?: any
  ): Promise<BlogInstance[]> {
    let result = await Blog.scope("public").findAll({
      where: {
        [Op.and]: [{ status: publish }, { title: { [Op.like]: `%${query}%` } }],
      },
      attributes: { exclude: ["content"] },
      order: [["last_publish", "DESC"]],
      include: [
        {
          model: Category,
          as: "category",
          where: categoryQuery
            ? { [Op.or]: [{ id: categoryQuery }, { path: categoryQuery }] }
            : undefined,
          through: { attributes: [] },
          attributes: ["id"],
          required: categoryQuery ? true : false,
        },
        {
          model: Tag,
          as: "tag",
          where: tagQuery
            ? { [Op.or]: [{ id: tagQuery }, { path: tagQuery }] }
            : undefined,
          through: { attributes: [] },
          attributes: ["id"],
          required: tagQuery ? true : false,
        },
      ],
    });

    let response: any[] = [];

    await Promise.all(
      result.map(async (blog) => {
        let newBlog: any = blog.toJSON();
        newBlog.category = await blog.getCategory({
          scope: "public",
          joinTableAttributes: [],
        });
        newBlog.tag = await blog.getTag({
          scope: "public",
          joinTableAttributes: [],
        });
        response.push(newBlog);
      })
    );

    return response;
  }

  public async updateRelateProduct(
    query: string,
    listNew: number[],
    transaction: Transaction
  ) {
    const blog = await Blog.findOne({
      where: {
        ...checkDelete,
        [Op.or]: [{ id: query }, { path: query }],
      },
    });
    const currentProduct: ProductInstance[] = await blog?.getProduct({
      attributes: ["id"],
    });

    let listToRemove: number[] = [];
    let listToAdd: number[] = [];
    let listCurrent: number[] = currentProduct.map((item) => Number(item.id));

    listToRemove = listCurrent.filter((item) => listNew.indexOf(item) < 0);
    listToAdd = listNew.filter(
      (item) => listToRemove.indexOf(item) < 0 && listCurrent.indexOf(item) < 0
    );

    await blog?.addProduct([...listToAdd], { transaction });
    await blog?.removeProduct([...listToRemove], { transaction });
  }

  public async sendToSubscriber(query: string) {
    const blog = await Blog.scope("public").findOne({
      where: {
        ...checkDelete,
        [Op.or]: [{ id: query }, { path: query }],
      },
    });

    if (!blog)
      throw new HttpError(StatusCodes.NOT_FOUND, "Không tìm thấy blog.");
    const listEmail = await Subscribe.findAll({
      where: {
        receive_blog: true,
      },
      attributes: ["email", "name"],
    });
    blog.update({
      send_mail: true,
    });

    sendMailBlog(blog, listEmail);
  }
}

export default BlogDao;
