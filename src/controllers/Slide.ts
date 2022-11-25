import BannerDao from "@daos/BannerSlide/Banner";
import SlideDao from "@daos/BannerSlide/Slide";
import SlideLocationDao from "@daos/BannerSlide/SlideLocation";
import HttpError from "@helper/iHttpError";
import { LIMIT_PER_PAGE, paramMissingError } from "@shared/constants";
import { createBannerSchema } from "@src/validator/Banner";
import {
  createSlideLocationSchema,
  createSlideSchema,
} from "@src/validator/Slide";
import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";

const slideDao = new SlideDao();
const locationDao = new SlideLocationDao();

export async function createLocation(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const value = await createSlideLocationSchema.validateAsync(req.body);
    const location = await locationDao.create(value);
    res.json(location);
  } catch (err) {
    next(err);
  }
}

export async function deleteLocation(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    await locationDao.delete(id);
    res.json({ id: id });
  } catch (err) {
    next(err);
  }
}

export async function searchLocation(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const list = await locationDao.search();
    res.json(list);
  } catch (err) {
    next(err);
  }
}

export async function createSlide(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const value = await createSlideSchema.validateAsync(req.body);
    const slide = await slideDao.create(value);
    res.json(slide);
  } catch (err) {
    next(err);
  }
}

export async function editSlide(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const value = await createSlideSchema.validateAsync(req.body);
    const slide = await slideDao.edit(id, value);
    res.json(slide);
  } catch (err) {
    next(err);
  }
}

export async function deleteSlide(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    await slideDao.delete(id);
    res.json({ id: id });
  } catch (err) {
    next(err);
  }
}

export async function getSlide(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const slide = await slideDao.find(id);
    res.json(slide);
  } catch (err) {
    next(err);
  }
}

export async function searchSlide(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const list = await slideDao.search();
    res.json(list);
  } catch (err) {
    next(err);
  }
}

export async function addBannerToSlide(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = Number(req.params.id);
    const bannerId = Number(req.body.bannerId);

    if (isNaN(id) || isNaN(bannerId))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);

    const list = await slideDao.addBanner(id, bannerId);
    res.json(list);
  } catch (err) {
    next(err);
  }
}

export async function removeBannerFromSlide(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = Number(req.params.id);
    const bannerId = Number(req.body.bannerId);

    if (isNaN(id) || isNaN(bannerId))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);

    const list = await slideDao.removeBanner(id, bannerId);
    res.json(list);
  } catch (err) {
    next(err);
  }
}

export async function updateBanner(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = Number(req.params.id);
    const bannerId = req.body.bannerId;

    if (isNaN(id) || !Array.isArray(bannerId))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);

    const list = await slideDao.updateBanner(id, bannerId);
    res.json(list);
  } catch (err) {
    next(err);
  }
}
