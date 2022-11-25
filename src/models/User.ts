import { Model, Optional, DataTypes, CreateOptions } from "sequelize";
import { signJWT, verifyJWT } from "../helper/jwt";
import { sequelize } from ".";
import { compare, hash } from "../helper/bcrypt";
import userRole from "../helper/user-role";
import Media from "./Media";
export interface UserAttributes {
  id: number;
  username: string;
  email: string;
  name: string;
  password: string;
  role: string;
  about: string;
  avatar: string;
  description: string;
}

export interface UserCreationAttributes
  extends Optional<UserAttributes, "id" | "about" | "avatar" | "description"> {}

export interface UserInstance
  extends Model<UserAttributes, UserCreationAttributes>,
    UserAttributes {
  createdAt?: Date;
  updatedAt?: Date;
  comparePassword: Function;
}

const User = sequelize.define<UserInstance>("User", {
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: DataTypes.INTEGER,
  },
  name: {
    type: DataTypes.STRING,
  },
  username: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true,
  },
  email: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true,
  },
  password: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  role: {
    type: DataTypes.ENUM(...userRole),
  },
  about: {
    type: DataTypes.TEXT,
  },
  description: {
    type: DataTypes.STRING,
  },
  avatar: {
    type: DataTypes.STRING,
  },
});

User.beforeCreate(async (instance, options) => {
  const hashedPassword = await hash(instance.password);
  console.log(hashedPassword);
  instance.password = hashedPassword;
});

User.prototype.comparePassword = async function (
  rawpassword: string
): Promise<Boolean> {
  return await compare(rawpassword, this.password);
};

export default User;
