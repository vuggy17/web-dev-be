import OrderDao from "@daos/Order/Order";
import HttpError from "@helper/iHttpError";
import { notFound, paramMissingError } from "@shared/constants";
import { editOrderSchema } from "@src/validator/Order";
import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";

const orderDao = new OrderDao();

export const searchOrder = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const statusQuery = String(req.query.status ?? "");
    const customer_email = req.query.customer_email
      ? String(req.query.customer_email)
      : null;
    const customer_name = req.query.customer_name
      ? String(req.query.customer_name)
      : null;

    const list = await orderDao.search(
      statusQuery,
      customer_name,
      customer_email
    );
    res.json(list);
  } catch (err) {
    next(err);
  }
};

export const editOrder = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const result = await editOrderSchema.validateAsync(req.body);
    const order = await orderDao.editOrder(id, result);
    res.json(order);
  } catch (err) {
    next(err);
  }
};

export const getOrder = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const order = await orderDao.getDetail(id);
    res.json(order);
  } catch (err) {
    next(err);
  }
};

export const sendMailConfirm = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const order = await orderDao.sendMailConfirm(id);
    res.json(order);
  } catch (err) {
    next(err);
  }
};

export const sendMailShipping = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const order = await orderDao.sendMailShipping(id);
    res.json(order);
  } catch (err) {
    next(err);
  }
};

export const getInvoice = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const id = Number(req.params.id);
    if (isNaN(id))
      throw new HttpError(StatusCodes.BAD_REQUEST, paramMissingError);
    const filename = await orderDao.getInvoice(id);
    res.json({ url: "/upload/" + filename });
  } catch (err) {
    next(err);
  }
};
