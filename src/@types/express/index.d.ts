import { IUser, jwtUser } from "@entities/User";

import { Request } from "express";
// declare module 'express' {
//     export interface Request  {
//         body: {
//             user: IUser
//         };
//     }
// }

declare global {
  namespace Express {
    interface Request {
      user: jwtUser;
    }
  }
}

export interface RequestWithUser extends Request {
  user: any;
}
