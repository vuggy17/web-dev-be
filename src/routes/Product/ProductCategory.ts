import { Router } from "express";
import {
  authenticationBlogger,
  authenticationUser,
} from "../../middleware/authentication";
import {
  createCategory,
  deleteCategory,
  editCategory,
  editCategoryOrder,
  getCategory,
  searchCategory,
} from "../../controllers/Product/ProductCategory";

// Category-route
const categoryRouter = Router();

categoryRouter.post(
  "/create",
  authenticationUser,
  authenticationBlogger,
  createCategory
);

categoryRouter.patch(
  "/order/:id",
  authenticationUser,
  authenticationBlogger,
  editCategoryOrder
);

categoryRouter.patch(
  "/:id",
  authenticationUser,
  authenticationBlogger,
  editCategory
);
categoryRouter.delete(
  "/:id",
  authenticationUser,
  authenticationBlogger,
  deleteCategory
);

categoryRouter.get(
  "/:id",
  authenticationUser,
  authenticationBlogger,
  getCategory
);
categoryRouter.get(
  "/",
  authenticationUser,
  authenticationBlogger,
  searchCategory
);

export default categoryRouter;
