import { Router } from "express";
import {
  authenticationBlogger,
  authenticationUser,
} from "../middleware/authentication";

import {
  createBlog,
  deleteBlog,
  editBlog,
  getBlog,
  searchBlog,
  sendToSubscriber,
} from "@src/controllers/Blog";

const blogRouter = Router();
blogRouter.post(
  "/create",
  authenticationUser,
  authenticationBlogger,
  createBlog
);
blogRouter.patch("/:id", authenticationUser, authenticationBlogger, editBlog);
blogRouter.delete(
  "/:id",
  authenticationUser,
  authenticationBlogger,
  deleteBlog
);

blogRouter.post(
  "/:id/send-mail",
  authenticationUser,
  authenticationBlogger,
  sendToSubscriber
);

blogRouter.get("/:id", authenticationUser, authenticationBlogger, getBlog);
blogRouter.get("/", authenticationUser, authenticationBlogger, searchBlog);

export default blogRouter;
