import { Router } from "express";
import {
  authenticationBlogger,
  authenticationUser,
} from "../middleware/authentication";
import {
  addBannerToSlide,
  createLocation,
  createSlide,
  deleteLocation,
  deleteSlide,
  editSlide,
  getSlide,
  removeBannerFromSlide,
  searchLocation,
  searchSlide,
  updateBanner,
} from "@src/controllers/Slide";

const slideRouter = Router();
slideRouter.post(
  "/create",
  authenticationUser,
  authenticationBlogger,
  createSlide
);
slideRouter.post(
  "/location/create",
  authenticationUser,
  authenticationBlogger,
  createLocation
);
slideRouter.patch("/:id", authenticationUser, authenticationBlogger, editSlide);
slideRouter.delete(
  "/location/:id",
  authenticationUser,
  authenticationBlogger,
  deleteLocation
);
slideRouter.delete(
  "/:id",
  authenticationUser,
  authenticationBlogger,
  deleteSlide
);
slideRouter.get("/location", searchLocation);
slideRouter.post(
  "/add-banner/:id",
  authenticationUser,
  authenticationBlogger,
  addBannerToSlide
);
slideRouter.delete(
  "/remove-banner/:id",
  authenticationUser,
  authenticationBlogger,
  removeBannerFromSlide
);
slideRouter.post(
  "/update-banner/:id",
  authenticationUser,
  authenticationBlogger,
  updateBanner
);
slideRouter.get("/:id", authenticationUser, authenticationBlogger, getSlide);
slideRouter.get("/", authenticationUser, authenticationBlogger, searchSlide);

export default slideRouter;
