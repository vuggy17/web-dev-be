// Put shared constants here

export const MAX_FILE_SIZE = 5;
export const UPLOAD_DESTINATION = "upload";
export const LIMIT_PER_PAGE = 10;

export const emailRegex = /^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6})*$/;
// error string
export const paramMissingError =
  "One or more of the required parameters was missing.";

export const loginFailed = "Login failed!";

export const unauthorized = "Unauthorized";

export const accessNotAllow = "Access is not allowed!";

export const uploadFailed = "Upload failed!";

export const wrongFileType = "Wrong file type";

export const fileNotFound = "File not found";

export const notFound = "Not found";

export const badRequest = "Bad request";

export const invalidInput = "Invalid input";

// enum

export const blogStatus = ["edit", "publish", "draft", "deleted"];
export const edit = blogStatus[0];
export const publish = blogStatus[1];
export const draft = blogStatus[2];
export const deleted = blogStatus[3];

export const bannerType = ["image", "cta"];
export const image = bannerType[0];
export const cta = bannerType[1];

export const orderStatus = ["pending", "shipping", "success", "cancel", "confirm"];
export const pending = orderStatus[0];
export const shipping = orderStatus[1];
export const success = orderStatus[2];
export const cancel = orderStatus[3];
export const confirm = orderStatus[4];
