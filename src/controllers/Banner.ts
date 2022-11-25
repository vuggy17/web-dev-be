import BannerDao from "@daos/BannerSlide/Banner";
import HttpError from "@helper/iHttpError";
import { LIMIT_PER_PAGE, paramMissingError } from "@shared/constants";
import { createBannerSchema, editBannerSchema } from "@src/validator/Banner";
import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";

const bannerDao = new BannerDao();

export async function createBanner(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const value = await createBannerSchema.validateAsync(req.body);
    const banner = await bannerDao.create(value);
    res.json(banner);
  } catch (err) {
    next(err);
  }
}

export async function editBanner(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const value = await editBannerSchema.validateAsync(req.body);
    const banner = await bannerDao.edit(id, value);
    res.json(banner);
  } catch (err) {
    next(err);
  }
}

export async function deleteBanner(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    await bannerDao.delete(id);
    res.json({ id: id });
  } catch (err) {
    next(err);
  }
}

export async function getBanner(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const blog = await bannerDao.find(id);
    res.json(blog);
  } catch (err) {
    next(err);
  }
}

export async function searchBanner(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const list = await bannerDao.search();
    res.json(list);
  } catch (err) {
    next(err);
  }
}
