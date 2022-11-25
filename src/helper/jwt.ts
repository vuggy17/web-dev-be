import "../pre-start";

import jwt from "jsonwebtoken";
import { jwtUser } from "@entities/User";

const secret = String(process.env.JWT_SECRET);

export const signJWT = (payload: string | object): string => {
  const token = jwt.sign(payload, secret, { expiresIn: "10 days" });
  return token;
};

export const verifyJWT = (token: any): any => {
  const value = jwt.verify(token, secret);
  return value;
};
