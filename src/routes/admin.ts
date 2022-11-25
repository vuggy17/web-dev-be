import { getAnalytics } from "@src/controllers/admin";
import { Router } from "express";
import {
  authenticationBlogger,
  authenticationUser,
} from "../middleware/authentication";


const adminRouter = Router();

adminRouter.get("/analytics", authenticationUser, authenticationBlogger, getAnalytics);

export default adminRouter;
