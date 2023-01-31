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

import cors from "cors";
import { sequelize } from "./models";
import HttpError from "./helper/iHttpError";
import { badRequest } from "@shared/constants";

const app = express();
const { BAD_REQUEST } = StatusCodes;
<<<<<<< Updated upstream
const isDev = process.env.NODE_ENV !== "production"

console.log('server mode: ', isDev ? 'Dev': "Prod" )
=======
const environment = process.env.NODE_ENV || 'development';
>>>>>>> Stashed changes

/************************************************************************************
 *                              Set basic express settings
 ***********************************************************************************/

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

// Show routes called in console during development
<<<<<<< Updated upstream
if (isDev) {
=======
if (environment === "development") {
>>>>>>> Stashed changes
  app.use(morgan("dev"));
  app.use(cors());
}

// Security
if (environment === "production") {
  app.use(helmet());
<<<<<<< Updated upstream
=======
  var whitelist = ["http://45.119.85.106:3000", "http://45.119.85.106:3001", "http://drdongphuong.com", "http://www.drdongphuong.com", "https://drdongphuong.com", "https://www.drdongphuong.com", "http://admin.drdongphuong.com", "https://admin.drdongphuong.com", "http://www.admin.drdongphuong.com", "https://www.admin.drdongphuong.com"];
>>>>>>> Stashed changes
  app.use(
    cors({
      origin: "*",
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

<<<<<<< Updated upstream
if (isDev) {
=======

if (environment === "development") {
>>>>>>> Stashed changes
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
    if (environment === "production") {
      return res.status(BAD_REQUEST).json({
        error: badRequest,
      });
    } else
      return res.status(BAD_REQUEST).json({
        error: err.message,
      });
  }
});

<<<<<<< Updated upstream
// if (process.env.SYNC_DATABASE){
// }

=======

// sequelize.sync({ alter: true });
// Export express instance
>>>>>>> Stashed changes
export default app;
