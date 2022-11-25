import CategoryDao from "@daos/Category/Category";
import { LIMIT_PER_PAGE, paramMissingError } from "@shared/constants";
import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import HttpError from "@src/helper/iHttpError";
import { categorySchema } from "@src/validator/Category";
import CommentDao from "@daos/Blog/Comment";
import { editCommentSchema } from "@src/validator/Comment";

const commentDao = new CommentDao();

export async function editComment(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const value = await editCommentSchema.validateAsync(req.body);

    const comment = await commentDao.edit(id, value);
    res.json(comment);
  } catch (err) {
    next(err);
  }
}

export async function deleteComment(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    await commentDao.delete(id);
    res.json({ id: id });
  } catch (err) {
    next(err);
  }
}

export async function searchComment(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const blogId = Number(req.query.blogId);
    const is_show = req.query.is_show ? req.query.is_show == "true" : null;
    if (isNaN(blogId))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const list = await commentDao.getAllCommentOfBlog(blogId, is_show);
    res.json(list);
  } catch (err) {
    next(err);
  }
}

export async function getComments(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const is_show = req.query.is_show ? req.query.is_show == "true" : null;
    const list = await commentDao.getComments(is_show);
    res.json(list);
  } catch (err) {
    next(err);
  }
}
