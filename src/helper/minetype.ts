import { wrongFileType } from "@shared/constants";
import multer from "multer";

const acceptType = ["image/jpg", "image/png", "image/jpeg"];

export default function minetypeFilter(
  req: Express.Request,
  file: Express.Multer.File,
  cb: multer.FileFilterCallback
) {
  if (acceptType.indexOf(file.mimetype) < 0) {
    return cb(new Error(wrongFileType));
  }
  cb(null, true);
}
