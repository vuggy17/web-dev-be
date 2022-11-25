import { Router } from "express";
import {
  authenticationBlogger,
  authenticationUser,
} from "../middleware/authentication";

import {
  sendMailConfirm,
  sendMailShipping,
  editOrder,
  getOrder,
  searchOrder,
  getInvoice,
} from "@src/controllers/Order";

const orderRouter = Router();

orderRouter.patch(
  "/confirm/:id",
  authenticationUser,
  authenticationBlogger,
  sendMailConfirm
);

orderRouter.patch(
  "/shipping/:id",
  authenticationUser,
  authenticationBlogger,
  sendMailShipping
);

orderRouter.get(
  "/invoice/:id",
  authenticationUser,
  authenticationBlogger,
  getInvoice
);

orderRouter.patch("/:id", authenticationUser, authenticationBlogger, editOrder);
orderRouter.get("/:id", authenticationUser, authenticationBlogger, getOrder);
orderRouter.get("/", authenticationUser, authenticationBlogger, searchOrder);

export default orderRouter;
