import AdminDao from "@daos/Admin/admin";

import { NextFunction, Request, Response } from "express";

const adminDao = new AdminDao();

export async function getAnalytics(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const data = await adminDao.getAnalytics();
    res.json(data);
  } catch (err) {
    next(err);
  }
}
