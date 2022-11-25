import { Model, Optional, DataTypes, CreateOptions } from "sequelize";
import { sequelize } from ".";
import { ProductInstance } from "./Product";
import { ProductVariantInstance } from "./ProductVariant";

interface OrderItemAttributes {
  product_id: number;
  variant_id: number;
  order_id: number;
  number: number;
  discount: number;
  total: number;
  product?: ProductInstance;
  ProductVariant?: ProductVariantInstance;
}

interface OrderItemCreationAttributes extends OrderItemAttributes {}

export interface OrderItemInstance
  extends Model<OrderItemAttributes, OrderItemCreationAttributes>,
    OrderItemAttributes {
  createdAt?: Date;
  updatedAt?: Date;
}

const OrderItem = sequelize.define<OrderItemInstance>("OrderItem", {
  product_id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
  },
  variant_id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
  },
  order_id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
  },
  number: {
    type: DataTypes.INTEGER,
  },
  total: {
    type: DataTypes.FLOAT,
    defaultValue: 0,

  },
  discount: {
    type: DataTypes.FLOAT,
    defaultValue: 0,
  },
});

export default OrderItem;
