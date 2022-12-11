import cookieParser from "cookie-parser";
import morgan from "morgan";
import path from "path";
import helmet from "helmet";

import express, { NextFunction, Request, Response } from "express";
import StatusCodes from "http-status-codes";
import "express-async-errors";

import BaseRouter from "./routes";
import logger from "@shared/Logger";

import swaggerUi from "swagger-ui-express";
import YAML from "yamljs";

import cors, { CorsOptions } from "cors";
import { sequelize } from "./models";
import HttpError from "./helper/iHttpError";
import { badRequest } from "@shared/constants";
import createInvoice from "@helper/invoice/generateInvoice";

const app = express();
const { BAD_REQUEST } = StatusCodes;

/************************************************************************************
 *                              Set basic express settings
 ***********************************************************************************/

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

// Show routes called in console during development
if (process.env.NODE_ENV === "development") {
  app.use(morgan("dev"));
  app.use(cors());
}

// Security
if (process.env.NODE_ENV === "production") {
  app.use(helmet());
  const whitelist = ["*"];
  app.use(
    cors({
      origin: whitelist,
    })
  );
}

// Add APIs
// app.use("/api", BaseRouter);

/************************************************************************************
 *                              Serve front-end content
 ***********************************************************************************/

const viewsDir = path.join(__dirname, "views");
app.set("views", viewsDir);
const staticDir = path.join(__dirname, "public");
app.use(express.static(staticDir));
app.use("/upload", express.static(path.join(__dirname, "../upload")));

if (process.env.NODE_ENV === "development") {
  const swaggerDocument = YAML.load(
    path.join(__dirname, "/shared/swagger.yaml")
  );

  app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerDocument));
}

app.use("/api", BaseRouter);

// Print API errors
// eslint-disable-next-line @typescript-eslint/no-unused-vars
app.use((err: HttpError, req: Request, res: Response, next: NextFunction) => {
  logger.err(err, true);
  if (err.status) {
    return res.status(err.status).json({
      error: err.message,
    });
  } else {
    if (process.env.NODE_ENV === "production") {
      return res.status(BAD_REQUEST).json({
        error: badRequest,
      });
    } else
      return res.status(BAD_REQUEST).json({
        error: err.message,
      });
  }
});

// sequelize.sync({ alter: true });
// Export express instance
export default app;
