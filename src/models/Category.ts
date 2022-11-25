import { generateSlug } from "@shared/functions";
import { Model, Optional, DataTypes, CreateOptions } from "sequelize";
import { sequelize } from ".";
import Blog from "./Blog";

export interface CategoryAttributes {
  id?: number;
  name: string;
  order?: string;
  description?: string;
  parent_id?: number;
  allow_sub?: boolean;
  path?: string;
}

interface CategoryCreationAttributes
  extends Optional<
    CategoryAttributes,
    "id" | "description" | "parent_id" | "allow_sub" | "path" | "order"
  > {}

export interface CategoryInstance
  extends Model<CategoryAttributes, CategoryCreationAttributes>,
    CategoryAttributes {
  createdAt?: Date;
  updatedAt?: Date;
  addBlogs: Function;
  removeBlog: Function;
  getBlogs: Function;
}

const Category = sequelize.define<CategoryInstance>("Category", {
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
  parent_id: {
    type: DataTypes.INTEGER,
  },
  allow_sub: {
    type: DataTypes.BOOLEAN,
    defaultValue: true,
  },
  path: {
    type: DataTypes.STRING,
  },
  order: {
    type: DataTypes.STRING
  }
});

Category.belongsTo(Category, {
  foreignKey: "parent_id",
  as: "parent",
  onDelete: "CASCADE",
});

Category.hasMany(Category, {
  sourceKey: "id",
  foreignKey: "parent_id",
  as: "children",
  onDelete: "CASCADE", 
});

Category.beforeSave((instance: CategoryInstance) => {
  instance.path = generateSlug(instance.name);
});

Category.addScope("public", {
  attributes: ["id", "name", "description", "createdAt", "path"],
  include: [{ model: Category, as: "parent", required: false }],
});

export default Category;
