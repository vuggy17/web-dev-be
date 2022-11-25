import Joi from "joi";

export const categorySchema = Joi.object({
  name: Joi.string().required(),
  description: Joi.string().allow("", null),
  parent_id: Joi.number(),
  allow_sub: Joi.boolean(),
  path: Joi.string(),
  order: Joi.number().allow(null),
});
