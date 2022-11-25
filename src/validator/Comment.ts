import { emailRegex } from "@shared/constants";
import Joi from "joi";

export const createCommentSchema = Joi.object({
  email: Joi.string().regex(emailRegex),
  phone: Joi.string(),
  name: Joi.string().required(),
  content: Joi.string().required(),
  blog_id: Joi.number().required(),
});

export const editCommentSchema = Joi.object({
  email: Joi.string().regex(emailRegex),
  phone: Joi.string(),
  name: Joi.string(),
  content: Joi.string(),
  is_show: Joi.boolean(),
  reply: Joi.string().allow("", null),
});
