import { generateSlug } from "@shared/functions";
import { Model, Optional, DataTypes, CreateOptions } from "sequelize";
import { sequelize } from ".";
import Blog from "./Blog";
import Product from "./Product";

export interface ProductCategoryAttributes {
  id?: number;
  name: string;
  order?: string;
  description?: string;
  parent_id?: number;
  allow_sub?: boolean;
  path?: string;
}

interface ProductCategoryCreationAttributes
  extends Optional<
    ProductCategoryAttributes,
    "id" | "description" | "parent_id" | "allow_sub" | "path" | "order"
  > {}

export interface ProductCategoryInstance
  extends Model<ProductCategoryAttributes, ProductCategoryCreationAttributes>,
    ProductCategoryAttributes {
  createdAt?: Date;
  updatedAt?: Date;
  addBlogs: Function;
  removeBlog: Function;
  getBlogs: Function;
}

const ProductCategory = sequelize.define<ProductCategoryInstance>(
  "ProductCategory",
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
  }
);

ProductCategory.belongsTo(ProductCategory, {
  foreignKey: "parent_id",
  as: "parent",
  onDelete: "SET NULL",
});

ProductCategory.beforeSave((instance: ProductCategoryInstance) => {
  instance.path = generateSlug(instance.name);
});

ProductCategory.addScope("public", {
  attributes: ["id", "name", "description", "createdAt", "path"],
  include: [{ model: ProductCategory, as: "parent", required: false }],
});

export default ProductCategory;
