/* eslint-disable @typescript-eslint/no-misused-promises */
import { Router } from "express";
import {
  getBlogDetail,
  getListBlog,
  getListCategory,
  getListTag,
  getSlideByLocation,
  createComment,
  getPublicCommentOfBlog,
  getLastedBlog,
  createOrder,
  getProduct,
  searchProduct,
  getProductRelateToBlog,
  getAbout,
  getBlogDetailPreview,
  searchProductCategory,
  getProductCategory,
  createSubscribe,
  getDealOfWeekProducts,
} from "@src/controllers/Landing";

const landingRouter = Router();

landingRouter.get("/slide/:location", getSlideByLocation);
landingRouter.get("/category", getListCategory);
landingRouter.get("/tag", getListTag);
landingRouter.get("/blog/new", getLastedBlog);
landingRouter.get("/blog/:query/product", getProductRelateToBlog);
landingRouter.get("/preview/:query", getBlogDetailPreview);
landingRouter.get("/blog/:query", getBlogDetail);
landingRouter.get("/blog", getListBlog);
landingRouter.get("/comment", getPublicCommentOfBlog);
landingRouter.get("/product/:id", getProduct);
landingRouter.get("/product", searchProduct);
landingRouter.get("/product-category/:id", getProductCategory);
landingRouter.get("/product-category", searchProductCategory);
landingRouter.get("/about", getAbout);
landingRouter.get("/deal-of-week", getDealOfWeekProducts);

landingRouter.post("/comment", createComment);
landingRouter.post("/order", createOrder);
landingRouter.post("/subscribe", createSubscribe);

export default landingRouter;
