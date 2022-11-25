import { orderStatus, pending } from "@shared/constants";
import { Model, Optional, DataTypes, CreateOptions } from "sequelize";
import { sequelize } from ".";
import OrderItem from "./OrderItem";

export interface OrderAttributes {
  id: number;
  customer_email: string;
  address: string;
  phone: string;
  product_money: number;
  promotion_money: number;
  total: number;
  status: string;
  customer_name: string;
  note: string;
  handle_note: string;
  mail_confirm: boolean;
  mail_shipping: boolean;
  invoice_name: string;
  items?: [any];
}

export type OrderCreationAttributes = Optional<
  OrderAttributes,
  | "id"
  | "total"
  | "status"
  | "handle_note"
  | "mail_confirm"
  | "mail_shipping"
  | "invoice_name"
>;

export interface OrderInstance
  extends Model<OrderAttributes, OrderCreationAttributes>,
    OrderAttributes {
  createdAt?: Date;
  updatedAt?: Date;
}

const Order = sequelize.define<OrderInstance>(
  "Order",
  {
    id: {
      allowNull: false,
      autoIncrement: true,
      primaryKey: true,
      type: DataTypes.INTEGER,
    },
    phone: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    customer_email: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    customer_name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    address: {
      type: DataTypes.STRING,
    },
    product_money: {
      type: DataTypes.FLOAT,
    },
    promotion_money: {
      type: DataTypes.FLOAT,
    },
    total: {
      type: DataTypes.FLOAT,
    },
    status: {
      type: DataTypes.ENUM(...orderStatus),
      defaultValue: pending,
    },
    note: {
      type: DataTypes.STRING,
    },
    handle_note: {
      type: DataTypes.STRING,
    },
    mail_confirm: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
      allowNull: true,
    },
    mail_shipping: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
      allowNull: true,
    },
    invoice_name: {
      type: DataTypes.STRING,
    },
  },
  {
    paranoid: true,
  }
);

Order.hasMany(OrderItem, {
  foreignKey: "order_id",
  as: "items",
});

OrderItem.belongsTo(Order, {
  foreignKey: "order_id",
  as: "items",
});

export default Order;
