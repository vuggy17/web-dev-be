import Joi from "joi";
import joi from "joi";
import userRole from "../helper/user-role";

export const loginSchema = joi.object({
  username: joi.string().required(),
  password: joi.string().required(),
});

export const createAccountSchema = joi.object({
  username: joi.string().required(),
  password: joi.string().required(),
  role: joi.string().allow(...userRole),
  name: joi.string().required(),
  email: joi.string().required(),
});

export const editUserSchema = Joi.object({
  password: joi.string(),
  name: joi.string(),
  email: joi.string(),
  about: joi.string(),
  description: joi.string(),
  avatar: joi.string(),
});
