import SubscribeDao from "@daos/Subscribe/Subscribe";
import HttpError from "@helper/iHttpError";
import { LIMIT_PER_PAGE, paramMissingError } from "@shared/constants";
import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
// import HttpError from "@src/helper/iHttpError";

const subscribeDao = new SubscribeDao();

// export async function getTag(req: Request, res: Response, next: NextFunction) {
//   try {
//     const query = req.params.id;
//     if (!query) throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
//     const category = await tagDao.find(query);
//     res.json(category);
//   } catch (err) {
//     next(err);
//   }
// }

export async function searchSubscribe(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const list = await subscribeDao.search();
    res.json(list);
  } catch (err) {
    next(err);
  }
}
