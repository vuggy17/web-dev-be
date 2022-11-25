import { Router } from "express";
import {
  authenticationBlogger,
  authenticationUser,
} from "../middleware/authentication";

import {
  createBanner,
  deleteBanner,
  editBanner,
  getBanner,
  searchBanner,
} from "@src/controllers/Banner";

const bannerRouter = Router();
bannerRouter.post(
  "/create",
  authenticationUser,
  authenticationBlogger,
  createBanner
);
bannerRouter.patch(
  "/:id",
  authenticationUser,
  authenticationBlogger,
  editBanner
);
bannerRouter.delete(
  "/:id",
  authenticationUser,
  authenticationBlogger,
  deleteBanner
);
bannerRouter.get("/:id", authenticationUser, authenticationBlogger, getBanner);
bannerRouter.get("/", authenticationUser, authenticationBlogger, searchBanner);

export default bannerRouter;
