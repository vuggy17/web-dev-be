import { bannerType, blogStatus, edit, publish } from "@shared/constants";
import { Model, Optional, DataTypes, CreateOptions } from "sequelize";
import { sequelize } from ".";
import Media from "./Media";

export interface BannerAttributes {
  id?: number;
  type: string;
  media_name: string;
  title: string;
  sub_title: string;
  content: string;
  button_text: string;
  button_url: string;
}

export interface BannerCreationAttributes
  extends Optional<
    BannerAttributes,
    "id" | "title" | "sub_title" | "content" | "button_text" | "button_url"
  > {}

export interface BannerInstance
  extends Model<BannerAttributes, BannerCreationAttributes>,
    BannerAttributes {
  createdAt?: Date;
  updatedAt?: Date;
}

const Banner = sequelize.define<BannerInstance>("Banner", {
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: DataTypes.INTEGER,
  },
  title: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  content: {
    type: DataTypes.TEXT,
  },
  sub_title: {
    type: DataTypes.STRING,
  },
  button_text: {
    type: DataTypes.STRING,
  },
  button_url: {
    type: DataTypes.STRING,
  },
  media_name: {
    type: DataTypes.STRING,
  },
  type: {
    type: DataTypes.ENUM(...bannerType),
  },
});

Banner.belongsTo(Media, {
  as: "media",
  foreignKey: "media_name",
  targetKey: "filename",
});

export default Banner;
