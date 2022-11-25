import { Router } from "express";
import {
  authenticationAdmin,
  authenticationUser,
} from "../middleware/authentication";
import {
  userLogin,
  initData,
  createAccount,
  editUser,
} from "../controllers/Users";

// User-route
const userRouter = Router();
userRouter.post("/login", userLogin);
userRouter.get("/init", initData);
userRouter.post(
  "/create",
  authenticationUser,
  authenticationAdmin,
  createAccount
);
userRouter.patch("/", authenticationUser, authenticationAdmin, editUser);

export default userRouter;
