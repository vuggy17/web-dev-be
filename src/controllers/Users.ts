import StatusCodes from "http-status-codes";
import { NextFunction, Request, Response } from "express";

import UserDao from "@daos/User/UserDao";
import { loginFailed, paramMissingError } from "@shared/constants";
import User from "../models/User";
import logger from "@shared/Logger";
import {
  createAccountSchema,
  editUserSchema,
  loginSchema,
} from "../validator/User";
import HttpError from "../helper/iHttpError";
import Category from "../models/Category";
import Tag from "@src/models/Tag";
import { LexoRank } from "lexorank";

const userDao = new UserDao();
const { BAD_REQUEST, CREATED, OK, UNAUTHORIZED } = StatusCodes;

export async function initData(req: Request, res: Response) {
  try {
    if (req.query.token == process.env.INIT_TOKEN) {
      await User.create({
        name: String(process.env.ADMIN_NAME),
        email: String(process.env.ADMIN_EMAIL),
        password: String(process.env.ADMIN_PASSWORD),
        username: String(process.env.ADMIN_USER),
        role: "admin",
      });

      await Category.create({
        name: "Uncategorized",
        allow_sub: false,
        order: LexoRank.max().toString(),
      });

      await Tag.create({
        name: "Untagged",
        description: "",
      });

      logger.info("Init data successfully!");
      return res.status(OK).json({ status: true });
    } else throw new Error("Token wrong!!");
  } catch (err) {
    console.log(err);
    logger.err("Init data failed!");
    logger.err(err);
    return res.status(OK).json({ status: false });
  }
}

export async function userLogin(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const value = await loginSchema.validateAsync(req.body);
    const token = await userDao.login(value.username, value.password);
    return res.status(OK).json({ token });
  } catch (err) {
    next(new HttpError(UNAUTHORIZED, loginFailed));
  }
}

export async function createAccount(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const value = await createAccountSchema.validateAsync(req.body);
    const user = await userDao.createAccount(
      value.username,
      value.password,
      value.role,
      value.name,
      value.email
    );
    res.json({
      username: user.username,
      role: user.role,
    });
  } catch (err) {
    next(err);
  }
}

export async function editUser(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const value = await editUserSchema.validateAsync(req.body);
    const user = req.user;
    await userDao.editUser(user.id, value);
    res.json({
      username: user.username,
      role: user.role,
    });
  } catch (err) {
    next(err);
  }
}
