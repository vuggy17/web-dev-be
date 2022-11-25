import { Model, Optional, DataTypes } from "sequelize";
import { sequelize } from ".";

export interface VariantOptionAttributes {
  id?: number;
  type_id: number;
  name: string;
  description: string;
}

export interface VariantOptionCreationAttributes
  extends Optional<VariantOptionAttributes, "id" | "description"> {}

export interface VariantOptionInstance
  extends Model<VariantOptionAttributes, VariantOptionCreationAttributes>,
    VariantOptionAttributes {
  createdAt?: Date;
  updatedAt?: Date;
}

const VariantOption = sequelize.define<VariantOptionInstance>("VariantOption", {
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: DataTypes.INTEGER,
  },
  type_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  description: {
    type: DataTypes.TEXT,
  },
});

export default VariantOption;
