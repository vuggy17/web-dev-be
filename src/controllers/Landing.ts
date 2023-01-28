import SlideDao from "@daos/BannerSlide/Slide";
import BlogDao from "@daos/Blog/Blog";
import CommentDao from "@daos/Blog/Comment";
import CategoryDao from "@daos/Category/Category";
import OrderDao from "@daos/Order/Order";
import ProductDao from "@daos/Product/Product";
import ProductCategoryDao from "@daos/Product/ProductCategory";
import SubscribeDao from "@daos/Subscribe/Subscribe";
import TagDao from "@daos/Tag/Tag";
import UserDao from "@daos/User/UserDao";
import HttpError from "@helper/iHttpError";
import sendMailConfirm from "@helper/mailService/sendMailConfirm";
import {
  LIMIT_PER_PAGE,
  notFound,
  paramMissingError,
  publish,
} from "@shared/constants";
import { createCommentSchema } from "@src/validator/Comment";
import { createOrderSchema } from "@src/validator/Order";
import { createSubscribeSchema } from "@src/validator/Subscribe";
import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";

const slideDao = new SlideDao();
const categoryDao = new CategoryDao();
const tagDao = new TagDao();
const blogDao = new BlogDao();
const commentDao = new CommentDao();
const orderDao = new OrderDao();
const productDao = new ProductDao();
const userDao = new UserDao();
const productCategory = new ProductCategoryDao();
const subscribeDao = new SubscribeDao();

export const getSlideByLocation = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const location = String(req.params.location);
    const slide = await slideDao.getSlideByLocation(location);
    res.json(slide);
  } catch (err) {
    next(err);
  }
};

export const getListCategory = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const list = await categoryDao.search("");
    res.json(list);
  } catch (err) {
    next(err);
  }
};

export const getListTag = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const list = await tagDao.search("");
    res.json(list);
  } catch (err) {
    next(err);
  }
};

export const getListBlog = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const query = String(req.query.query ?? "");
    const category = req.query.category;
    const tag = req.query.tag;
    const list = await blogDao.searchPublic(query, category, tag);
    res.json(list);
  } catch (err) {
    next(err);
  }
};

export const getBlogDetail = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const query = String(req.params.query);
    // only publish blog here
    const blog = await blogDao.findPublic(query);
    if (blog.status != publish)
      throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    await blog.update({
      view: blog.view + 1,
    });
    res.json(blog);
  } catch (err) {
    next(err);
  }
};

export const getBlogDetailPreview = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const query = String(req.params.query);
    const blog = await blogDao.find(query);
    res.json(blog);
  } catch (err) {
    next(err);
  }
};

export const createComment = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const value = await createCommentSchema.validateAsync(req.body);
    const comment = await commentDao.create(value.blog_id, value);
    res.json(comment);
  } catch (err) {
    next(err);
  }
};

export const getPublicCommentOfBlog = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const blogId = Number(req.query.blogId);
    if (isNaN(blogId))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const list = await commentDao.getAllCommentOfBlog(blogId, true);
    res.json(list);
  } catch (err) {
    next(err);
  }
};

export const getLastedBlog = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const limit = Number(req.query.limit ?? LIMIT_PER_PAGE);
    const list = await blogDao.getLastedBlog(limit);
    res.json(list);
  } catch (err) {
    next(err);
  }
};

export const createOrder = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const value = await createOrderSchema.validateAsync(req.body);
    const order = await orderDao.createOrder(value);

    res.json(order);
  } catch (err) {
    next(err);
  }
};

export async function getProduct(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = req.params.id;
    if (!id) throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const product = await productDao.findPublic(id);
    res.json(product);
  } catch (err) {
    next(err);
  }
}

export async function getProductRelateToBlog(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const query = req.params.query;
    if (!query) throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const product = await productDao.findProductRelateToBlog(query);
    res.json(product);
  } catch (err) {
    next(err);
  }
}

type SortType = "price"  |  "name"
type SortDirection =  "DESC" | "ASC"
export async function searchProduct(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const query = String(req.query.query ?? "");
    const categoryQuery = String(req.query.category ?? "");

    const filter = {
       prices: req.query.priceStart && req.query.priceEnd ? {
        start: parseInt(req.query.priceStart as string),
        end:parseInt(req.query.priceEnd as string),
      }:undefined,
      categories :undefined  as any,
    }
    const sort = req.query.sort ? req.query.sort as SortType: undefined;
    const sortType = req.query.sortType ?  req.query.sortType as SortDirection:undefined;
    const page = req.query.page ?  parseInt(req.query.page as string):undefined;
    const maxPage = req.query.maxPage ?  parseInt(req.query.maxPage as string) : undefined;
    if (categoryQuery != ""){
      filter.categories = await productCategory.findAllRelateCategories(categoryQuery).then((c)=> {
        return c.length > 0 ?c.map(cata=>cata.id): undefined
      })
      console.log("filter.categories",filter.categories,categoryQuery);

    }

   const list =  await productDao.findProduct({
      filter:filter,
      sort:sort,
      sortType:sortType,
      pagination:{
        page:page as number,
        maxPage:maxPage as number
      },
      search: query ,
    })
    // if (categoryQuery == "") {
    //   list = await productDao.searchPublic(query);
    //   res.json(list);
    // } else {
    // list = await productDao.findAllProductOfCategory(categoryQuery);
    //   res.json(list);
    // }
    res.json(list);
  } catch (err) {
    next(err);
  }
}

export async function searchProductCategory(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const query = String(req.query.query ?? "");
    const list = await productCategory.search(query);
    res.json(list);
  } catch (err) {
    next(err);
  }
}

export async function getProductCategory(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const id = req.params.id;
    if (!id) throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const category = await productCategory.find(id);
    res.json(category);
  } catch (err) {
    next(err);
  }
}

export async function getAbout(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const about = await userDao.getAbout();
    res.json(about);
  } catch (err) {
    next(err);
  }
}

export async function createSubscribe(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const value = await createSubscribeSchema.validateAsync(req.body);
    const subscribe = await subscribeDao.create(value);
    res.json({ status: "success" });
  } catch (err) {
    next(err);
  }
}

export async function getDealOfWeekProducts(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const list = await productDao.getDealOfWeekProducts();
    res.json(list);
  } catch (err) {
    next(err);
  }
}
