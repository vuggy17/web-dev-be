import { invalidInput, notFound } from "@shared/constants";
import { StatusCodes } from "http-status-codes";
import Category, {
  CategoryAttributes,
  CategoryInstance,
} from "../../models/Category";
import { Op } from "sequelize";
import HttpError from "@helper/iHttpError";
import { LexoRank } from "lexorank";

class CategoryDao {
  public async create(data: CategoryAttributes): Promise<CategoryInstance> {
    if (data.parent_id) {
      const parent = await Category.findOne({
        where: {
          id: data.parent_id,
        },
      });
      if (!parent || parent.allow_sub == false) throw new Error(invalidInput);
    }
    const minOrder = await Category.findAll({
      limit: 1,
      order: [["order", "ASC"]],
    });
    const order = minOrder[0]
      ? LexoRank.parse(minOrder[0].order!).genPrev()
      : LexoRank.max();

    const category = await Category.create({
      ...data,
      order: order.toString(),
    });
    return category;
  }

  public async edit(
    id: number,
    data: CategoryAttributes
  ): Promise<CategoryInstance> {
    const category = await Category.findOne({
      where: { id: id },
    });
    if (category == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    await category.update(data);

    return category;
  }

  public async delete(id: number): Promise<void> {
    const category = await Category.findOne({
      where: { id: id },
    });
    if (category == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    await category.destroy();
  }

  public async find(id: number): Promise<CategoryInstance> {
    const category = await Category.findOne({
      where: { id: id },
      include: [{ model: Category, as: "children" }],
    });
    if (category == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    return category;
  }

  public async search(query?: string): Promise<CategoryInstance[]> {
    const list = await Category.findAll({
      where: {
        name: { [Op.like]: `%${query}%` },
      },
      order: [["order", "DESC"]],
    });
    return list;
  }

  public async editOrder(
    id: number,
    before: number | null,
    after: number | null
  ): Promise<CategoryInstance> {
    if (!before && !after) throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    const category = await Category.findOne({
      where: { id: id },
    });

    const beforeTarget = before
      ? await Category.findOne({
          where: { id: before },
        })
      : null;
    const afterTarget = after
      ? await Category.findOne({
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
}

export default CategoryDao;
