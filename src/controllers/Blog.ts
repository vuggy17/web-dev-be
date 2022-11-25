import BlogDao from "@daos/Blog/Blog";
import { blogCreateSchema, blogEditSchema } from "@src/validator/Blog";
import { NextFunction, Request, Response } from "express";

const blogDao = new BlogDao();

export async function createBlog(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const value = await blogCreateSchema.validateAsync(req.body);
    const blog = await blogDao.create(value);
    res.json(blog);
  } catch (err) {
    next(err);
  }
}

export async function editBlog(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = String(req.params.id);
    const value = await blogEditSchema.validateAsync(req.body);
    const blog = await blogDao.edit(id, value);
    res.json(blog);
  } catch (err) {
    next(err);
  }
}

export async function deleteBlog(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = String(req.params.id);
    await blogDao.delete(id);
    res.json({ id: id });
  } catch (err) {
    next(err);
  }
}

export async function getBlog(req: Request, res: Response, next: NextFunction) {
  try {
    const id = String(req.params.id);
    const blog = await blogDao.find(id);
    res.json(blog);
  } catch (err) {
    next(err);
  }
}

export async function searchBlog(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const query = String(req.query.query ?? "");
    const status = req.query.status;
    const categoryId = req.query.categoryId;
    const tagId = req.query.tagId;
    const list = await blogDao.search(query, categoryId, tagId, status);
    res.json(list);
  } catch (err) {
    next(err);
  }
}

export async function sendToSubscriber(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const query = String(req.params.id ?? "");
    await blogDao.sendToSubscriber(query);
    res.json({ status: "success" });
  } catch (err) {
    next(err);
  }
}
