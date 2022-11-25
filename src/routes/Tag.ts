import { Router } from "express";
import {
  authenticationBlogger,
  authenticationUser,
} from "../middleware/authentication";

import {
  createTag,
  deleteTag,
  editTag,
  getTag,
  searchTag,
} from "../controllers/Tag";

// Category-route
const tagRouter = Router();
tagRouter.post("/create", authenticationUser, authenticationBlogger, createTag);
tagRouter.patch("/:id", authenticationUser, authenticationBlogger, editTag);
tagRouter.delete("/:id", authenticationUser, authenticationBlogger, deleteTag);
tagRouter.get("/:id", authenticationUser, authenticationBlogger, getTag);
tagRouter.get("/", authenticationUser, authenticationBlogger, searchTag);

export default tagRouter;
