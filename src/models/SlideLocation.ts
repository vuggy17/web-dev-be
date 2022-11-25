import { Model, Optional, DataTypes, CreateOptions } from "sequelize";
import { sequelize } from ".";

export interface SlideLocationAttributes {
  id?: number;
  name: string;
}

export interface SlideLocationCreationAttributes
  extends Optional<SlideLocationAttributes, "id"> {}

export interface SlideLocationInstance
  extends Model<SlideLocationAttributes, SlideLocationCreationAttributes>,
    SlideLocationAttributes {
  createdAt?: Date;
  updatedAt?: Date;
}

const SlideLocation = sequelize.define<SlideLocationInstance>("SlideLocation", {
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: DataTypes.INTEGER,
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true,
  },
});

export default SlideLocation;
