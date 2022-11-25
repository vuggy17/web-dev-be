import logger from "@shared/Logger";
import bcrypt from "bcrypt";

export const hash = async (myPlaintextPassword: string) => {
  try {
    const hash = await bcrypt.hash(myPlaintextPassword, 10);
    return hash;
  } catch (err) {
    logger.err("Hash function not working");
    throw new Error("Hash function not working");
  }
};

export const compare = async (myPlaintextPassword: string, hash: string) => {
  try {
    const result = await bcrypt.compare(myPlaintextPassword, hash);
    return result;
  } catch (err) {
    logger.err("Compare function not working");
    throw new Error("Compare function not working");
  }
};
