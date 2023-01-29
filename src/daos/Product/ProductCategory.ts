import HttpError from "@helper/iHttpError";
import { notFound } from "@shared/constants";
import ProductCategory, {
  ProductCategoryAttributes,
  ProductCategoryInstance,
} from "@src/models/ProductCategory";
import { StatusCodes } from "http-status-codes";
import { LexoRank } from "lexorank";
import { Op } from "sequelize";

class ProductCategoryDao {
  public async create(
    data: ProductCategoryAttributes
  ): Promise<ProductCategoryInstance> {
    let parentCategory = null;
    if (data.parent_id) {
      parentCategory = await ProductCategory.findOne({
        where: {
          id: data.parent_id,
          allow_sub: true,
        },
      });
    }
    if (data.parent_id && !parentCategory)
      throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    const minOrder = await ProductCategory.findAll({
      limit: 1,
      order: [["order", "ASC"]],
    });
    const order = minOrder[0]
      ? LexoRank.parse(minOrder[0].order!).genPrev()
      : LexoRank.max();
    const category = await ProductCategory.create({
      ...data,
      order: order.toString(),
    });
    return category;
  }

  public async edit(
    query: any,
    data: ProductCategoryAttributes
  ): Promise<ProductCategoryInstance> {
    let parentCategory = null;

    if (data.parent_id) {
      parentCategory = await ProductCategory.findOne({
        where: {
          id: data.parent_id,
          allow_sub: true,
        },
      });
    }
    const category = await ProductCategory.findOne({
      where: {
        [Op.or]: [{ id: query }, { path: query }],
      },
    });
    if ((data.parent_id && !parentCategory) || !category)
      throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    if (data.order != null) {
      const target = await ProductCategory.findOne({
        where: { order: data.order },
      });
      if (target != null) target.update({ order: category.order });
    }
    await category.update({ ...data });
    return category;
  }

  public async delete(query: any): Promise<void> {
    const category = await ProductCategory.findOne({
      where: {
        [Op.or]: [{ id: query }, { path: query }],
      },
    });

    await category?.destroy();
  }

  public async search(query: string): Promise<ProductCategoryInstance[]> {
    const list = await ProductCategory.findAll({
      where: {
        name: { [Op.like]: `%${query}%` },
      },
      order: [["order", "DESC"]],
    });
    return list;
  }

  public async find(query: any): Promise<ProductCategoryInstance> {
    const category = await ProductCategory.findOne({
      where: {
        [Op.or]: [{ id: query }, { path: query }],
      },
    });

    if (!category) throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    return category;
  }

  public async findAllChild(
    parent: ProductCategoryInstance
  ): Promise<ProductCategoryInstance[]> {
    const returnList = [parent];
    let newList = [];
    let currentI = 0;
    do {
      newList = [];
      newList = await ProductCategory.findAll({
        where: {
          parent_id: returnList[currentI].id,
        },
      });
      returnList.push(...newList);
      currentI++;
    } while (newList.length > 0 || currentI < returnList.length);

    return returnList;
  }

  public async editOrder(
    id: number,
    before: number | null,
    after: number | null
  ): Promise<ProductCategoryInstance> {
    if (!before && !after) throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    const category = await ProductCategory.findOne({
      where: { id: id },
    });

    const beforeTarget = before
      ? await ProductCategory.findOne({
          where: { id: before },
        })
      : null;
    const afterTarget = after
      ? await ProductCategory.findOne({
          where: { id: after },
        })
      : null;

    if (
      category == null ||
      (before != null && beforeTarget == null) ||
      (after != null && afterTarget == null)
    )
      throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    const beforeRank = beforeTarget
      ? LexoRank.parse(beforeTarget.order ?? "")
      : LexoRank.min();

    const afterRank = afterTarget
      ? LexoRank.parse(afterTarget.order ?? "")
      : LexoRank.max();

    const currentRank = LexoRank.parse(category.order!);

    let newRank = null;

    if (!before) {
      // newRank = LexoRank.max().between(afterRank).toString();
      // await afterTarget?.update({ order: currentRank.genNext().toString() });
      if (afterRank.toString() == LexoRank.max().toString()) {
        await afterTarget?.update({
          order: LexoRank.max().genPrev().toString(),
        });
        newRank = LexoRank.max().toString();
      } else {
        newRank = afterRank.genNext().toString();
      }
    } else if (!after) {
      newRank = beforeRank.genPrev().toString();
    } else if (beforeRank.toString() == afterRank.toString()) {
      await afterTarget?.update({ order: afterRank.genNext().toString() });
      await beforeTarget?.update({ order: beforeRank.genPrev().toString() });

      newRank = beforeRank.genPrev().between(afterRank.genNext()).toString();
    } else {
      newRank = beforeRank.between(afterRank).toString();
    }

    if (newRank) await category.update({ order: newRank });
    return category;
  }
  public async findAllRelateCategories(_search:string){
    let listCategory = [];
    const category = await ProductCategory.findOne({
      where: {
        [Op.or]: [{ id: _search }, { path: _search }],
      },
    });
    console.log("cate",category);

    if (!category) return [];

    if (category.parent_id == null) {
      listCategory = await this.findAllChild(category);
    } else {
      listCategory.push(category);
    }
    return listCategory;
  }
}

export default ProductCategoryDao;
