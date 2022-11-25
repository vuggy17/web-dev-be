import {
  deleteComment,
  editComment,
  getComments,
  searchComment,
} from "@src/controllers/Comment";
import { Router } from "express";
import {
  authenticationBlogger,
  authenticationUser,
} from "../middleware/authentication";

const commentRouter = Router();

commentRouter.patch(
  "/:id",
  authenticationUser,
  authenticationBlogger,
  editComment
);

commentRouter.delete(
  "/:id",
  authenticationUser,
  authenticationBlogger,
  deleteComment
);

commentRouter.get(
  "/all",
  authenticationUser,
  authenticationBlogger,
  getComments
);

commentRouter.get(
  "/",
  authenticationUser,
  authenticationBlogger,
  searchComment
);

export default commentRouter;
