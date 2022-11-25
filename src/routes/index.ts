import { Router } from "express";
import categoryRouter from "./Category";
import mediaRouter from "./Media";
import userRouter from "./Users";
import tagRouter from "./Tag";
import blogRouter from "./Blog";
import bannerRouter from "./Banner";
import slideRouter from "./Slide";
import landingRouter from "./Landing";
import commentRouter from "./Comment";
import productRouter from "./Product";
import orderRouter from "./Order";
import subscribeRouter from "./Subscribe";
import adminRouter from "./admin";

// Export the base-router
const baseRouter = Router();
baseRouter.get("/", (req, res, next) => {
  res.json({
    status: true,
  });
});
baseRouter.use("/users", userRouter);
baseRouter.use("/media", mediaRouter);
baseRouter.use("/category", categoryRouter);
baseRouter.use("/tag", tagRouter);
baseRouter.use("/blog", blogRouter);
baseRouter.use("/slide", slideRouter);
baseRouter.use("/banner", bannerRouter);
baseRouter.use("/landing", landingRouter);
baseRouter.use("/comment", commentRouter);
baseRouter.use("/product", productRouter);
baseRouter.use("/order", orderRouter);
baseRouter.use("/subscribe", subscribeRouter);
baseRouter.use("/admin", adminRouter)

export default baseRouter;
