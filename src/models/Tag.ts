import { generateSlug } from "@shared/functions";
import { Model, Optional, DataTypes, CreateOptions } from "sequelize";
import { sequelize } from ".";
import Blog from "./Blog";

export interface TagAttributes {
  id?: number;
  name: string;
  description: string;
  path?: string;
}

interface TagCreationAttributes
  extends Optional<TagAttributes, "id" | "path"> {}

export interface TagInstance
  extends Model<TagAttributes, TagCreationAttributes>,
    TagAttributes {
  createdAt?: Date;
  updatedAt?: Date;
  addBlogs: Function;
  removeBlog: Function;
}

const Tag = sequelize.define<TagInstance>("Tag", {
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: DataTypes.INTEGER,
  },
  name: {
    allowNull: false,
    type: DataTypes.STRING,
    unique: true,
  },
  description: {
    type: DataTypes.STRING,
  },
  path: {
    type: DataTypes.STRING,
    unique: true,
  },
});

Tag.beforeSave((instance: TagInstance) => {
  instance.path = generateSlug(instance.name);
});

Tag.addScope("public", {
  attributes: ["id", "name", "description", "createdAt", "path"],
});

export default Tag;
