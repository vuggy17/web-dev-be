import { IUser } from "@entities/User";
import HttpError from "@helper/iHttpError";
import { notFound } from "@shared/constants";
import Media from "@src/models/Media";
import { StatusCodes } from "http-status-codes";
import { signJWT } from "../../helper/jwt";
import User, { UserAttributes, UserInstance } from "../../models/User";

export interface IUserDao {
  login: (username: string, password: string) => Promise<Boolean | string>;
  createAccount: (
    username: string,
    password: string,
    role: string,
    email: string,
    name: string
  ) => Promise<UserInstance>;
}

class UserDao implements IUserDao {
  public async login(
    username: string,
    password: string
  ): Promise<Boolean | string> {
    const user = await User.findOne({
      where: {
        username: username,
      },
    });
    if (user != null) {
      const result = await user?.comparePassword(password);
      if (result == true) {
        return signJWT({
          id: user.id,
          username: user.username,
          role: user.role,
        });
      } else throw new Error("Wrong password!");
    } else throw new Error("Not found user!");
  }

  public async createAccount(
    username: string,
    password: string,
    role: string,
    name: string,
    email: string
  ): Promise<UserInstance> {
    const user = await User.create({
      username,
      password,
      role,
      email,
      name,
    });
    return user;
  }

  public async editUser(id: number, value: UserAttributes): Promise<void> {
    let thumbnail = null;
    const user = await User.findByPk(id);
    if (value.avatar) {
      thumbnail = await Media.findOne({
        where: {
          filename: value.avatar,
        },
      });
    }

    if (value.avatar && thumbnail == null)
      throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    await user?.update({
      ...value,
      avatar: thumbnail?.url,
    });
  }

  public async getAbout(): Promise<UserInstance | null> {
    const userAbout = await User.findOne({
      where: {
        username: process.env.ADMIN_USER,
      },
      attributes: ["name", "about", "avatar", "description"],
    });
    return userAbout;
  }
}

export default UserDao;
