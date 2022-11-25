import Joi from "joi";

export const createProductSchema = Joi.object({
  name: Joi.string().required(),
  description: Joi.string().allow("", null),
  category_id: Joi.number().required(),
  media: Joi.array().items(Joi.number()),
  thumbnail: Joi.string().required(),
  price: Joi.number().required(),
  is_on_sale: Joi.boolean(),
  discount: Joi.number().max(1).min(0),
  SKU: Joi.string().allow("", null),
  is_track_inventory: Joi.boolean(),
  is_in_stock: Joi.boolean(),
  is_publish: Joi.boolean(),
  brand: Joi.string().allow("", null),
  shipping_infor: Joi.string().allow("", null),
  return_infor: Joi.string().allow("", null),
  manual_infor: Joi.string().allow("", null),
  content: Joi.string().allow("", null),
  maxDiscount: Joi.number().allow("", null),
  brand_infor: Joi.string().allow("", null),
  deal_of_week: Joi.bool(),
});

export const editProductSchema = Joi.object({
  name: Joi.string(),
  description: Joi.string().allow("", null),
  category_id: Joi.number(),
  media: Joi.array().items(Joi.number()),
  thumbnail: Joi.string(),
  price: Joi.number(),
  is_on_sale: Joi.boolean(),
  discount: Joi.number().max(1).min(0),
  SKU: Joi.string().allow("", null),
  is_track_inventory: Joi.boolean(),
  is_in_stock: Joi.boolean(),
  is_publish: Joi.boolean(),
  brand: Joi.string().allow("", null),
  shipping_infor: Joi.string().allow("", null),
  return_infor: Joi.string().allow("", null),
  manual_infor: Joi.string().allow("", null),
  content: Joi.string().allow("", null),
  maxDiscount: Joi.number().allow("", null),
  brand_infor: Joi.string().allow("", null),
  deal_of_week: Joi.bool(),
});

export const createVariantSchema = Joi.object({
  name: Joi.string().required(),
  description: Joi.string().allow("", null),
  product_id: Joi.number().required(),
  price: Joi.number().required(),
});

export const editVariantSchema = Joi.object({
  name: Joi.string(),
  description: Joi.string().allow("", null),
  price: Joi.number(),
});
