import ProductDao from "@daos/Product/Product";
import { LIMIT_PER_PAGE, paramMissingError } from "@shared/constants";
import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import HttpError from "@src/helper/iHttpError";
import {
  createProductSchema,
  createVariantSchema,
  editProductSchema,
  editVariantSchema,
} from "@src/validator/Product/Product";
import ProductVariantDao from "@daos/Product/ProductVariant";

const productDao = new ProductDao();
const variantDao = new ProductVariantDao();

export async function createProduct(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const value = await createProductSchema.validateAsync(req.body);
    const product = await productDao.create(value);
    res.json(product);
  } catch (err) {
    next(err);
  }
}

export async function editProduct(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = req.params.id;
    if (!id) throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const value = await editProductSchema.validateAsync(req.body);
    const product = await productDao.edit(id, value);
    res.json(product);
  } catch (err) {
    next(err);
  }
}

export async function deleteProduct(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = req.params.id;
    if (!id) throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    await productDao.delete(id);
    res.json({ id: id });
  } catch (err) {
    next(err);
  }
}

export async function getProduct(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = req.params.id;
    if (!id) throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const product = await productDao.find(id);
    res.json(product);
  } catch (err) {
    next(err);
  }
}

export async function searchProduct(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const query = String(req.query.query ?? "");
    const categoryQuery = String(req.query.category ?? "");
    let list = [];
    if (categoryQuery == "") {
      list = await productDao.search(query);
      res.json(list);
    } else {
      list = await productDao.findAllProductOfCategory(categoryQuery);
      res.json(list);
    }
  } catch (err) {
    next(err);
  }
}

export async function createVariant(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const result = await createVariantSchema.validateAsync(req.body);
    const variant = await variantDao.create(result);
    res.json(variant);
  } catch (err) {
    next(err);
  }
}

export async function editVariant(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const result = await editVariantSchema.validateAsync(req.body);
    const variant = await variantDao.edit(id, result);
    res.json(variant);
  } catch (err) {
    next(err);
  }
}

export async function deleteVariant(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    await variantDao.delete(id);
    res.json({ id: id });
  } catch (err) {
    next(err);
  }
}
