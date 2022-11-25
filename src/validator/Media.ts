import Joi from "joi";

export const editMediaSchema = Joi.object({
  alt: Joi.string().allow("", null),
  title: Joi.string().allow("", null),
});
