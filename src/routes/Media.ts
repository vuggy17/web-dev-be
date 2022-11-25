import { Router, Request, Response, NextFunction } from "express";
import {
  authenticationBlogger,
  authenticationUser,
} from "../middleware/authentication";
import multer from "multer";
import {
  fileNotFound,
  MAX_FILE_SIZE,
  UPLOAD_DESTINATION,
} from "@shared/constants";
import minetypeFilter from "../helper/minetype";
import { MediaAttributes } from "../models/Media";
import MediaDao from "@daos/Media/MediaDao";
import {
  deleteMedia,
  editMediaInformation,
  searchMedia,
  getMedia,
} from "../controllers/Media";

const mediaDao = new MediaDao();

const mediaRouter = Router();
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, UPLOAD_DESTINATION);
  },
  filename: function (req, file, cb) {
    cb(
      null,
      file.originalname.split(".")[0] +
        "-" +
        Date.now() +
        file.originalname.slice(file.originalname.indexOf("."))
    ); // strict here
  },
});

const upload = multer({
  storage: storage,
  fileFilter: minetypeFilter,
  limits: {
    fileSize: MAX_FILE_SIZE * 1024 * 1024,
  },
}).single("file");

mediaRouter.patch(
  "/:filename",
  authenticationUser,
  authenticationBlogger,
  editMediaInformation
);

mediaRouter.delete(
  "/:filename",
  authenticationUser,
  authenticationBlogger,
  deleteMedia
);

mediaRouter.get("/", authenticationUser, authenticationBlogger, searchMedia);
mediaRouter.get(
  "/:filename",
  authenticationUser,
  authenticationBlogger,
  getMedia
);

mediaRouter.post(
  "/upload",
  authenticationUser,
  authenticationBlogger,
  function (req: Request, res: Response, next: NextFunction) {
    upload(req, res, async function (err) {
      if (err instanceof multer.MulterError) {
        return next(new Error(err.message));
      } else if (err) {
        return next(new Error(err));
      }
      const file = req.file;
      if (file) {
        const media: MediaAttributes = {
          filename: file.filename,
          filesize: file.size,
          filetype: file.mimetype,
          uploadBy: req.user.username,
          title: file.filename,
          url: `/upload/${file.filename}`,
          alt: "",
        };
        const result = await mediaDao.saveFileInfor(media);
        res.json(result);
      } else next(new Error(fileNotFound));
    });
  }
);

export default mediaRouter;
