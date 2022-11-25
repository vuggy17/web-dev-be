import { notFound } from "@shared/constants";
import { StatusCodes } from "http-status-codes";
import HttpError from "@helper/iHttpError";

import { Op } from "sequelize";
import Tag, { TagAttributes, TagInstance } from "../../models/Tag";

class TagDao {
  public async create(data: TagAttributes): Promise<TagInstance> {
    const tag = await Tag.create({
      ...data,
    });
    return tag;
  }

  public async edit(
    query: number | string,
    data: TagAttributes
  ): Promise<TagInstance> {
    const tag = await Tag.findOne({
      where: { [Op.or]: [{ id: query }, { path: query }] },
    });
    if (tag == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    await tag.update(data);
    return tag;
  }

  public async delete(id: number): Promise<void> {
    const tag = await Tag.findOne({
      where: { id: id },
    });
    if (tag == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    await tag.destroy();
  }

  public async find(query: number | string): Promise<TagInstance> {
    const tag = await Tag.findOne({
      where: { [Op.or]: [{ id: query }, { path: query }] },
    });
    if (tag == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    return tag;
  }

  public async search(query?: string): Promise<TagInstance[]> {
    const list = await Tag.findAll({
      where: { name: { [Op.like]: `%${query}%` } },
    });

    return list;
  }
}

export default TagDao;
