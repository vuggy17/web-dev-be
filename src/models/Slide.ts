import { Model, Optional, DataTypes, CreateOptions } from "sequelize";
import { sequelize } from ".";
import Banner from "./Banner";
import SlideLocation from "./SlideLocation";

export interface SlideAttributes {
  id?: number;
  location_id: number;
  is_visible: boolean;
  name: string;
}

export interface SlideCreationAttributes
  extends Optional<SlideAttributes, "id"> {}

export interface SlideInstance
  extends Model<SlideAttributes, SlideCreationAttributes>,
    SlideAttributes {
  createdAt?: Date;
  updatedAt?: Date;
  addBanners: Function;
  removeBanner: Function;
  getBanners: Function;
  removeBanners: Function;
}

const Slide = sequelize.define<SlideInstance>("Slide", {
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: DataTypes.INTEGER,
  },
  location_id: {
    type: DataTypes.INTEGER,
    unique: true,
  },
  is_visible: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
  name: {
    type: DataTypes.STRING,
  }
});

Slide.belongsToMany(Banner, {
  through: "Slide_Banner",
  as: "banners",
});

SlideLocation.hasOne(Slide, { as: "slide" });

Slide.belongsTo(SlideLocation, {
  foreignKey: "location_id",
  as: "location",
});

export default Slide;
