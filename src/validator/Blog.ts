import { blogStatus } from "@shared/constants";
import Joi from "joi";

export const blogCreateSchema = Joi.object({
  title: Joi.string().required(),
  status: Joi.string().allow(...blogStatus),
  path: Joi.string(),
  content: Joi.string().required(),
  visible: Joi.boolean(),
  feature_image: Joi.string().allow("", null),
  description: Joi.string().allow("", null),
  allow_comment: Joi.boolean(),
  stick_to_top: Joi.boolean(),
  category: Joi.array().items(Joi.number()),
  tag: Joi.array().items(Joi.number()),
  product: Joi.array().items(Joi.number()),
});

export const blogEditSchema = Joi.object({
  title: Joi.string(),
  status: Joi.string().allow(...blogStatus),
  path: Joi.string(),
  content: Joi.string(),
  visible: Joi.boolean(),
  feature_image: Joi.string().allow("", null),
  description: Joi.string().allow("", null),
  allow_comment: Joi.boolean(),
  stick_to_top: Joi.boolean(),
  category: Joi.array().items(Joi.number()),
  tag: Joi.array().items(Joi.number()),
  product: Joi.array().items(Joi.number()),
});
