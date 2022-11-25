import CategoryDao from "@daos/Category/Category";
import { LIMIT_PER_PAGE, paramMissingError } from "@shared/constants";
import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import HttpError from "@src/helper/iHttpError";
import { categorySchema } from "@src/validator/Category";

const categoryDao = new CategoryDao();

export async function createCategory(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const value = await categorySchema.validateAsync(req.body);
    const category = await categoryDao.create(value);
    res.json(category);
  } catch (err) {
    next(err);
  }
}

export async function editCategory(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const value = await categorySchema.validateAsync(req.body);
    const category = await categoryDao.edit(id, value);
    res.json(category);
  } catch (err) {
    next(err);
  }
}

export async function deleteCategory(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    await categoryDao.delete(id);
    res.json({ id: id });
  } catch (err) {
    next(err);
  }
}

export async function getCategory(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const category = await categoryDao.find(id);
    res.json(category);
  } catch (err) {
    next(err);
  }
}

export async function searchCategory(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const query = String(req.query.query ?? "");
    const list = await categoryDao.search(query);
    res.json(list);
  } catch (err) {
    next(err);
  }
}

export async function editCategoryOrder(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = Number(req.params.id);
    const before = req.query.beforeId ? Number(req.query.beforeId) : null;
    const after = req.query.afterId ? Number(req.query.afterId) : null;
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const category = await categoryDao.editOrder(id, before, after);
    res.json(category);
  } catch (err) {
    next(err);
  }
}
