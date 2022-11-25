import { notFound } from "@shared/constants";
import { StatusCodes } from "http-status-codes";
import HttpError from "@helper/iHttpError";

import { Op } from "sequelize";
import Subscribe, {
  SubscibeAttributes,
  SubscribeInstance,
} from "@src/models/Subscribe";
import { hash } from "@helper/bcrypt";

class SubscribeDao {
  public async create(data: SubscibeAttributes): Promise<SubscribeInstance> {
    const findData = await Subscribe.findOne({
      where: {
        email: data.email,
      },
    });
    if (findData) throw new HttpError(422, "Email đã được đăng ký từ trước!");

    const secret_key = await hash(data.email);

    const tag = await Subscribe.create({
      ...data,
      secret_key,
    });
    return tag;
  }

  public async search(): Promise<SubscribeInstance[]> {
    const findData = await Subscribe.scope("public").findAll({});

    return findData;
  }
}

export default SubscribeDao;
