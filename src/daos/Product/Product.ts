/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable @typescript-eslint/require-await */
/* eslint-disable @typescript-eslint/no-misused-promises */
import MediaDao from "@daos/Media/MediaDao";
import HttpError from "@helper/iHttpError";
import { notFound } from "@shared/constants";
import Blog from "@src/models/Blog";
import Media, { MediaInstance } from "@src/models/Media";
import Product, {
  ProductCreationAttributes,
  ProductInstance,
} from "@src/models/Product";
import ProductCategory, {
  ProductCategoryInstance,
} from "@src/models/ProductCategory";
import ProductVariant from "@src/models/ProductVariant";
import { StatusCodes } from "http-status-codes";
import { Includeable, Op } from "sequelize";
import ProductCategoryDao from "./ProductCategory";

const productCategoryDao = new ProductCategoryDao();
const mediaDao = new MediaDao();

class ProductDao {
  public async create(
    data: ProductCreationAttributes
  ): Promise<ProductInstance> {
    let category = null;
    let thumbnail = null;

    if (data.category_id) {
      category = await productCategoryDao.find(data.category_id);
    }

    if (data.thumbnail) {
      thumbnail = await mediaDao.find(data.thumbnail);
    }

    if (!category || !thumbnail)
      throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    const product = await Product.create({ ...data, thumbnail: thumbnail.url });

    if (data.media) {
      await this.updateMedia(String(product.id), data.media);
    }

    return product;
  }

  public async edit(
    query: any,
    data: ProductCreationAttributes
  ): Promise<ProductInstance> {
    let parentCategory = null;
    let thumbnail = null;

    if (data.category_id) {
      parentCategory = await ProductCategory.findOne({
        where: {
          id: data.category_id,
        },
      });
    }

    if (data.thumbnail) {
      thumbnail = await Media.findOne({ where: { filename: data.thumbnail } });
    }

    const product = await Product.findOne({
      where: {
        [Op.or]: [{ id: query }, { path: query }],
      },
    });

    if (!product) throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    if (data.media) {
      await this.updateMedia(query, data.media);
    }

    await product.update({ ...data, thumbnail: thumbnail?.url });

    return product;
  }

  public async delete(query: any): Promise<void> {
    const product = await Product.findOne({
      where: {
        [Op.or]: [{ id: query }, { path: query }],
      },
    });

    await product?.destroy();
  }

  public async search(query: string): Promise<ProductInstance[]> {
    return Product.scope(["withCategory", "withVariant", "withMedia"]).findAll({
      where: {
        name: {
          [Op.like]: `%${query}%`,
        },
      },
      order: [["createdAt", "DESC"]],
    });
  }

  public async searchPublic(query: string): Promise<ProductInstance[]> {
    return Product.scope("public").findAll({
      where: {
        name: {
          [Op.like]: `%${query}%`,
        },
      },
    });
  }

  public async find(query: string): Promise<ProductInstance> {
    const product = await Product.scope([
      "withCategory",
      "withVariant",
      "withMedia",
    ]).findOne({
      where: {
        [Op.or]: [{ id: query }, { path: query }],
      },
    });

    if (!product) throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    return product;
  }

  public async findPublic(query: string): Promise<ProductInstance> {
    const product = await Product.scope("public").findOne({
      where: {
        [Op.or]: [{ id: query }, { path: query }],
      },
    });

    if (!product) throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    return product;
  }

  public async findAllProductOfCategory(
    category_query: string
  ): Promise<ProductInstance[]> {
    let listCategory = [];
    let listProduct: ProductInstance[] = [];
    const category = await productCategoryDao.find(category_query);
    if (!category) throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    if (category.parent_id == null) {
      listCategory = await productCategoryDao.findAllChild(category);
    } else {
      listCategory.push(category);
    }

    const requests = listCategory.map(async (item) => {
      const list = await this.findProductOfCategory(item);
      listProduct = [...listProduct, ...list];
    });

    await Promise.all(requests);
    return listProduct;
  }

  public async findProductOfCategory(
    category: ProductCategoryInstance
  ): Promise<ProductInstance[]> {
    return Product.scope("public").findAll({
      where: {
        category_id: category.id,
      },
    });
  }

  public async updateMedia(query: string, newList: number[]): Promise<void> {
    const listToRemove: number[] = [];
    const listToAdd: number[] = [];

    const product = await Product.findOne({
      where: {
        [Op.or]: [{ id: query }, { path: query }],
      },
      include: [{ model: Media, as: "media" }],
    });

    product?.media?.forEach((item) => {
      if (item.id && newList.indexOf(item.id) < 0) {
        listToRemove.push(item.id);
      }
    });

    newList.forEach((item) => {
      if (listToRemove.indexOf(item) < 0) {
        listToAdd.push(item);
      }
    });

    const listMediaAdd = await Media.findAll({
      where: {
        id: {
          [Op.in]: [...listToAdd],
        },
      },
    });

    const listMediaRemove = await Media.findAll({
      where: {
        id: {
          [Op.in]: [...listToRemove],
        },
      },
    });

    listMediaAdd.forEach(async (item) => {
      product?.addMedia(item.id);
    });

    listMediaRemove.forEach(async (item) => {
      product?.removeMedia(item.id);
    });
  }

  public async findProductRelateToBlog(
    query: string
  ): Promise<ProductInstance[]> {
    const blog = await Blog.findOne({
      where: {
        [Op.or]: [{ id: query }, { path: query }],
      },
    });
    if (blog == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    const listProduct: ProductInstance[] = await blog.getProduct();

    return listProduct;
  }

  public async getDealOfWeekProducts(): Promise<ProductInstance[]> {
    return Product.scope("public").findAll({
      where: {
        deal_of_week: true,
      },
    });
  }

  public async findProduct(_:{
    filter : {
      prices?:{
        start: number,
        end:number,
      }
      categories?:string[],
    },
    sort?:"price" | "name",
    sortType?:"ASC" | "DESC",
    pagination:{
      page?:number,
      maxPage?:number,
    },
    search?: string
  }): Promise<ProductInstance[]> {
    let wherePharse = { };

    if (_.search && _.search.trim()) {
      wherePharse= {
        name: {
          [Op.like]: `%${_.search}%`,
        },
      }
    }
    if (_.filter){
      if (_.filter.prices){
        wherePharse = {
          ...wherePharse,
          price: {
            [Op.between]: [_.filter.prices.start, _.filter.prices.end],
          },
        }
      }
      if (_.filter.categories){
        wherePharse = {
          ...wherePharse,
          category_id: {
            [Op.in]: _.filter.categories,
          },
        }
      }
    }
    const orderPharse: [['name'|'price', 'ASC'|'DESC']?]  = []
    if (_.sort && _.sortType){
      orderPharse.push([_.sort, _.sortType])
    }
    const pagination:{
      offset?:number,
      limit?:number,
    } = {
    }
    if (_.pagination.maxPage && _.pagination.page){
      const {page, maxPage} = _.pagination
      pagination.offset = (page - 1) * maxPage
      pagination.limit = maxPage
    }
    console.log({
      where: wherePharse,
      order: orderPharse as any,
      ...pagination
    });
    console.log(wherePharse);

    return Product.scope("public").findAll({
      where: wherePharse,
      order: orderPharse as any,
      ...pagination
    });
  }

}

export default ProductDao;
