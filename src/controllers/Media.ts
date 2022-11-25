import MediaDao from "@daos/Media/MediaDao";
import { LIMIT_PER_PAGE } from "@shared/constants";
import { NextFunction, Request, Response } from "express";
import { editMediaSchema } from "../validator/Media";

const mediaDao = new MediaDao();

export async function editMediaInformation(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const { filename } = req.params;
    const value = await editMediaSchema.validateAsync(req.body);
    const media = await mediaDao.editFileInfor(filename, value);
    res.json(media);
  } catch (err) {
    next(err);
  }
}

export async function deleteMedia(
  req: Request,
  res: Response,
  next: NextFunction
) {
  const { filename } = req.params;
  try {
    await mediaDao.deleteFile(filename);
    res.json({ filename: filename });
  } catch (err) {
    res.json({ filename: filename });
  }
}

export async function searchMedia(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const page = Number(req.query.page ?? 1);
    const limit = Number(req.query.limit ?? LIMIT_PER_PAGE);
    const query = String(req.query.query ?? "");
    const offset = (page - 1) * limit;
    const list = await mediaDao.search(query);
    res.json(list);
  } catch (err) {
    next(err);
  }
}

export async function getMedia(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const filename = String(req.params.filename);
    const file = await mediaDao.find(filename);
    res.json(file);
  } catch (err) {
    next(err);
  }
}
