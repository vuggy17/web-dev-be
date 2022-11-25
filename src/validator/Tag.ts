import Joi from "joi";

export const tagSchema = Joi.object({
  name: Joi.string().required(),
  description: Joi.string().allow("", null),
});
