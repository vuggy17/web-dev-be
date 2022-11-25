import { bannerType } from "@shared/constants";
import Joi from "joi";

export const createBannerSchema = Joi.object({
  type: Joi.string()
    .allow(...bannerType)
    .required(),
  media_name: Joi.string().required(),
  title: Joi.string().allow("", null),
  sub_title: Joi.string().allow("", null),
  content: Joi.string().allow("", null),
  button_text: Joi.string().allow("", null),
  button_url: Joi.string().allow("", null),
});

export const editBannerSchema = Joi.object({
  type: Joi.string().allow(...bannerType),
  media_name: Joi.string(),
  title: Joi.string().allow("", null),
  sub_title: Joi.string().allow("", null),
  content: Joi.string().allow("", null),
  button_text: Joi.string().allow("", null),
  button_url: Joi.string().allow("", null),
});
