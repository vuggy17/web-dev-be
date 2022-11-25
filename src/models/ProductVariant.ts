import { generateSlug } from "@shared/functions";
import { count } from "console";
import { Model, Optional, DataTypes, CreateOptions } from "sequelize";
import { sequelize } from ".";
import Media, { MediaInstance } from "./Media";
import OrderItem from "./OrderItem";
import Product, { ProductInstance } from "./Product";

export interface ProductVariantAttributes {
  id?: number;
  name: string;
  product_id: number;
  description: string;
  price: number;
}

export interface ProductVariantCreationAttributes
  extends Optional<ProductVariantAttributes, "id"> {}

export interface ProductVariantInstance
  extends Model<ProductVariantAttributes, ProductVariantCreationAttributes>,
    ProductVariantAttributes {
  Product: ProductInstance;
  createdAt?: Date;
  updatedAt?: Date;
}

const ProductVariant = sequelize.define<ProductVariantInstance>(
  "ProductVariant",
  {
    id: {
      allowNull: false,
      autoIncrement: true,
      primaryKey: true,
      type: DataTypes.INTEGER,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    price: {
      type: DataTypes.FLOAT,
      allowNull: false,
      validate: {
        min: 0,
      },
    },
    product_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
  },
  { paranoid: true }
);

// OrderItem.belongsTo(ProductVariant, {
//   foreignKey: "variant_id",
//   as: "variant",
// });

ProductVariant.addScope("public", {
  attributes: { exclude: ["createdAt", "updatedAt", "deletedAt"] },
});

export default ProductVariant;
