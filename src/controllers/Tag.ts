import TagDao from "@daos/Tag/Tag";
import HttpError from "@helper/iHttpError";
import { LIMIT_PER_PAGE, paramMissingError } from "@shared/constants";
import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
// import HttpError from "@src/helper/iHttpError";
import { tagSchema } from "../validator/Tag";

const tagDao = new TagDao();

export async function createTag(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const value = await tagSchema.validateAsync(req.body);
    const tag = await tagDao.create(value);
    res.json(tag);
  } catch (err) {
    next(err);
  }
}

export async function editTag(req: Request, res: Response, next: NextFunction) {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const value = await tagSchema.validateAsync(req.body);
    const tag = await tagDao.edit(id, value);
    res.json(tag);
  } catch (err) {
    next(err);
  }
}

export async function deleteTag(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    await tagDao.delete(id);
    res.json({ id: id });
  } catch (err) {
    next(err);
  }
}

export async function getTag(req: Request, res: Response, next: NextFunction) {
  try {
    const query = req.params.id;
    if (!query) throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const category = await tagDao.find(query);
    res.json(category);
  } catch (err) {
    next(err);
  }
}

export async function searchTag(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const query = String(req.query.query ?? "");
    const list = await tagDao.search(query);
    res.json(list);
  } catch (err) {
    next(err);
  }
}
