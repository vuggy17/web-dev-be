import { generateSlug } from "@shared/functions";
import { Model, Optional, DataTypes, CreateOptions } from "sequelize";
import { sequelize } from ".";

export interface SubscibeAttributes {
  id?: number;
  name: string;
  email: string;
  secret_key: string;
  receive_blog: boolean;
  receive_product: boolean;
  receive_news: boolean;
}

interface SubscribeCreationAttributes
  extends Optional<
    SubscibeAttributes,
    "id" | "receive_blog" | "receive_product" | "receive_news" | "secret_key"
  > {}

export interface SubscribeInstance
  extends Model<SubscibeAttributes, SubscribeCreationAttributes>,
    SubscibeAttributes {
  createdAt?: Date;
  updatedAt?: Date;
}

const Subscribe = sequelize.define<SubscribeInstance>(
  "Subscribe",
  {
    id: {
      allowNull: false,
      autoIncrement: true,
      primaryKey: true,
      type: DataTypes.INTEGER,
    },
    name: {
      allowNull: false,
      type: DataTypes.STRING,
    },
    email: {
      allowNull: false,
      type: DataTypes.STRING,
      unique: true,
    },
    secret_key: {
      allowNull: false,
      type: DataTypes.STRING,
    },
    receive_blog: {
      type: DataTypes.BOOLEAN,
      defaultValue: true,
    },
    receive_product: {
      type: DataTypes.BOOLEAN,
      defaultValue: true,
    },
    receive_news: {
      type: DataTypes.BOOLEAN,
      defaultValue: true,
    },
  },
  {
    paranoid: true,
  }
);

Subscribe.addScope("public", {
  attributes: ["id", "name", "email"],
});

export default Subscribe;
