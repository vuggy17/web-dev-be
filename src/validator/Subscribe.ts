import Joi from "joi";

export const createSubscribeSchema = Joi.object({
  email: Joi.string().email().required(),
  name: Joi.string().required(),
});
