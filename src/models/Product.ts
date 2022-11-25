import { generateSlug } from "@shared/functions";
import { Model, Optional, DataTypes } from "sequelize";
import { sequelize } from ".";
import Blog from "./Blog";
import Media from "./Media";
import OrderItem from "./OrderItem";
import ProductCategory from "./ProductCategory";
import ProductVariant from "./ProductVariant";

export interface ProductAttributes {
  id?: number;
  name: string;
  description: string;
  rating: number;
  category_id: number;
  path: string;
  thumbnail: string;
  view: number;
  price: number;
  is_on_sale: boolean;
  discount: number;
  SKU: string;
  is_track_inventory: boolean;
  is_in_stock: boolean;
  is_publish: boolean;
  brand: string;
  shipping_infor: string;
  return_infor: string;
  manual_infor: string;
  brand_infor: string;
  content: string;
  maxDiscount: number;
  deal_of_week: boolean;
  media?: any[];
}

export interface ProductCreationAttributes
  extends Optional<
    ProductAttributes,
    | "id"
    | "rating"
    | "path"
    | "view"
    | "is_on_sale"
    | "discount"
    | "is_track_inventory"
    | "is_in_stock"
    | "is_publish"
    | "brand"
    | "brand_infor"
    | "manual_infor"
    | "return_infor"
    | "shipping_infor"
    | "content"
    | "maxDiscount"
    | "deal_of_week"
  > {}

export interface ProductInstance
  extends Model<ProductAttributes, ProductCreationAttributes>,
    ProductAttributes {
  createdAt?: Date;
  updatedAt?: Date;
  addMedia: Function;
  removeMedia: Function;
}

const Product = sequelize.define<ProductInstance>(
  "Product",
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
    path: {
      type: DataTypes.STRING,
      unique: true,
    },
    rating: {
      type: DataTypes.FLOAT,
      allowNull: false,
      defaultValue: 0,
    },
    category_id: {
      type: DataTypes.INTEGER,
      // allowNull: false,
    },
    thumbnail: {
      type: DataTypes.STRING,
    },
    price: {
      type: DataTypes.FLOAT,
      defaultValue: 0,
    },
    view: {
      type: DataTypes.INTEGER,
      defaultValue: 0,
    },
    is_on_sale: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
    },
    discount: {
      type: DataTypes.FLOAT,
      defaultValue: 0,
      validate: {
        min: 0,
        max: 1,
      },
    },
    SKU: {
      type: DataTypes.STRING,
    },
    is_track_inventory: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
    },
    is_in_stock: {
      type: DataTypes.BOOLEAN,
      defaultValue: true,
    },
    is_publish: {
      type: DataTypes.BOOLEAN,
      defaultValue: true,
    },
    brand: {
      type: DataTypes.STRING,
    },
    shipping_infor: {
      type: DataTypes.TEXT,
    },
    return_infor: {
      type: DataTypes.TEXT,
    },
    manual_infor: {
      type: DataTypes.TEXT,
    },
    brand_infor: {
      type: DataTypes.TEXT,
    },
    content: {
      type: DataTypes.TEXT,
    },
    maxDiscount: {
      type: DataTypes.INTEGER,
    },
    deal_of_week: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
    },
  },
  {
    paranoid: true,
  }
);

Media.belongsToMany(Product, {
  through: "Product_Media",
  as: "media",
});

Product.belongsToMany(Media, {
  through: "Product_Media",
  as: "media",
});

ProductCategory.hasMany(Product, {
  sourceKey: "id",
  foreignKey: "category_id",
  as: "products",
  onDelete: "SET NULL",
});

Product.belongsTo(ProductCategory, {
  foreignKey: "category_id",
  as: "category",
  onDelete: "SET NULL",
});

Product.hasMany(ProductVariant, {
  foreignKey: "product_id",
  as: "variants",
});

ProductVariant.belongsTo(Product, {
  foreignKey: "product_id",
});

OrderItem.belongsTo(Product, {
  foreignKey: "product_id",
  as: "product",
});

Product.beforeDestroy((instance: ProductInstance) => {
  const deleteTime = new Date().getTime();
  instance.path = instance.path + "-deleted-" + deleteTime;
  instance.name = instance.name + "-deleted-" + deleteTime;
});

Product.beforeSave((instance: ProductInstance) => {
  if (!instance.path) instance.path = generateSlug(instance.name);
});

Product.addScope("public", {
  attributes: { exclude: ["createdAt", "updatedAt", "deletedAt"] },
  include: [
    {
      model: ProductCategory.scope("public"),
      as: "category",
      required: false,
    },
    {
      model: Media.scope("public"),
      as: "media",
      through: { attributes: [] },
    },
    {
      model: ProductVariant.scope("public"),
      as: "variants",
      required: false,
    },
  ],
});

Product.addScope("withCategory", {
  include: [
    {
      model: ProductCategory,
      as: "category",
      required: false,
    },
  ],
});

Product.addScope("withMedia", {
  include: [
    {
      model: Media,
      as: "media",
      through: { attributes: [] },
    },
  ],
});

Product.addScope("withVariant", {
  include: [
    {
      model: ProductVariant,
      as: "variants",
      required: false,
    },
  ],
});

export default Product;
