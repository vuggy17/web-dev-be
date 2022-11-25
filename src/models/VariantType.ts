import { Model, Optional, DataTypes } from "sequelize";
import { sequelize } from ".";

export interface VariantTypeAttributes {
  id?: number;
  name: string;
  description: string;
}

export interface VariantTypeCreationAttributes
  extends Optional<VariantTypeAttributes, "id" | "description"> {}

export interface VariantTypeInstance
  extends Model<VariantTypeAttributes, VariantTypeCreationAttributes>,
    VariantTypeAttributes {
  createdAt?: Date;
  updatedAt?: Date;
}

const VariantType = sequelize.define<VariantTypeInstance>("VariantType", {
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
  },
});

export default VariantType;
