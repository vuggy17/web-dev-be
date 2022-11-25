import { Router } from "express";
import {
  authenticationBlogger,
  authenticationUser,
} from "../middleware/authentication";

import { searchSubscribe } from "../controllers/Subscribe";

// Category-route
const subscribeRouter = Router();
subscribeRouter.get(
  "/",
  authenticationUser,
  authenticationBlogger,
  searchSubscribe
);

export default subscribeRouter;
