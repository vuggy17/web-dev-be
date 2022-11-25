import { Model, Optional, DataTypes, CreateOptions } from "sequelize";
import { sequelize } from ".";

interface CustomerAttributes {
  id: number;
  email: string;
  name: string;
  address: string;
  phone: string;
}

interface CustomerCreationAttributes
  extends Optional<CustomerAttributes, "id"> {}

export interface CustomerInstance
  extends Model<CustomerAttributes, CustomerCreationAttributes>,
    CustomerAttributes {
  createdAt?: Date;
  updatedAt?: Date;
}

const Customer = sequelize.define<CustomerInstance>("Customer", {
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: DataTypes.INTEGER,
  },
  name: {
    type: DataTypes.STRING,
  },
  email: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true,
  },
  phone: {
    type: DataTypes.STRING,
  },
  address: {
    type: DataTypes.STRING,
  },
});

export default Customer;
