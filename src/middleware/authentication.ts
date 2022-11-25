import { accessNotAllow, loginFailed, unauthorized } from "@shared/constants";
import { NextFunction, Request, Response, RequestHandler } from "express";
import { StatusCodes } from "http-status-codes";
// import { RequestWithUser } from "../@types/express";
import { verifyJWT } from "../helper/jwt";
import HttpError from "../helper/iHttpError";
import { admin, blogger } from "../helper/user-role";

export const authenticationUser =  (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const authHeader = req.headers["authorization"];
    const token = authHeader && authHeader.split(" ")[1];
    const user = verifyJWT(token);
    req.user = user;
    next();
  } catch (err) {
    next(new HttpError(StatusCodes.UNAUTHORIZED, unauthorized));
  }
};

export const authenticationAdmin =  (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const user = req.user;
    if (user && user.role == admin) return next();
    throw new Error(accessNotAllow);
  } catch (err) {
    next(new HttpError(StatusCodes.UNAUTHORIZED, unauthorized));
  }
};

export const authenticationBlogger =  (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const user = req.user;
    if (user && (user.role == admin || user.role == blogger)) return next();
    throw new Error(accessNotAllow);
  } catch (err) {
    next(new HttpError(StatusCodes.UNAUTHORIZED, unauthorized));
  }
};
