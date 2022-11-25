import Joi from "joi";

export const createSlideLocationSchema = Joi.object({
  name: Joi.string().required(),
});

export const createSlideSchema = Joi.object({
  location_id: Joi.number(),
  is_visible: Joi.boolean(),
  name: Joi.string(),
});
