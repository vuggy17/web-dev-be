import { emailRegex, orderStatus } from "@shared/constants";
import Joi from "joi";

export const createOrderSchema = Joi.object({
  customer_email: Joi.string().pattern(emailRegex).required(),
  customer_name: Joi.string().required(),
  phone: Joi.string().required(),
  address: Joi.string().required(),
  note: Joi.string().allow("", null),
  items: Joi.array()
    .items({
      product_id: Joi.number().required(),
      variant_id: Joi.number().required(),
      number: Joi.number().required(),
    })
    .required(),
});

export const editOrderSchema = Joi.object({
  customer_email: Joi.string().pattern(emailRegex),
  customer_name: Joi.string().allow("", null),
  phone: Joi.string(),
  address: Joi.string(),
  status: Joi.string().allow(...orderStatus),
  note: Joi.string(),
  handle_note: Joi.string().allow("", null),
  items: Joi.array().items({
    product_id: Joi.number(),
    variant_id: Joi.number(),
    number: Joi.number(),
  }),
});
