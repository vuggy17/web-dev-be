import logger from "./Logger";
import urlSlug from "url-slug";

export const pErr = (err: Error) => {
  if (err) {
    logger.err(err);
  }
};

export const getRandomInt = () => {
  return Math.floor(Math.random() * 1_000_000_000_000);
};

export const generateSlug = (input: string) => {
  return urlSlug(input);
};
