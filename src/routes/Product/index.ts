import {
  createProduct,
  createVariant,
  deleteProduct,
  deleteVariant,
  editProduct,
  editVariant,
  getProduct,
  searchProduct,
} from "@src/controllers/Product/Product";
import {
  authenticationBlogger,
  authenticationUser,
} from "@src/middleware/authentication";
import { Router } from "express";
import categoryRouter from "./ProductCategory";

// Export the base-router
const productRouter = Router();

productRouter.post(
  "/variant/create",
  authenticationUser,
  authenticationBlogger,
  createVariant
);

productRouter.delete(
  "/variant/:id",
  authenticationUser,
  authenticationBlogger,
  deleteVariant
);

productRouter.patch(
  "/variant/:id",
  authenticationUser,
  authenticationBlogger,
  editVariant
);
productRouter.use("/category", categoryRouter);

productRouter.post(
  "/create",
  authenticationUser,
  authenticationBlogger,
  createProduct
);
productRouter.patch(
  "/:id",
  authenticationUser,
  authenticationBlogger,
  editProduct
);
productRouter.delete(
  "/:id",
  authenticationUser,
  authenticationBlogger,
  deleteProduct
);

productRouter.get(
  "/:id",
  authenticationUser,
  authenticationBlogger,
  getProduct
);
productRouter.get(
  "/",
  authenticationUser,
  authenticationBlogger,
  searchProduct
);

export default productRouter;
