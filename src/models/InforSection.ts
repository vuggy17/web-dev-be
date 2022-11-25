// import { Model, Optional, DataTypes } from "sequelize";
// import { sequelize } from ".";

// export interface InforSectionAttributes {
//   id?: number;
//   title: string;
//   content: string;
// }

// export interface InforSectionCreationAttributes
//   extends Optional<InforSectionAttributes, "id"> {}

// export interface InforSectionInstance
//   extends Model<InforSectionAttributes, InforSectionCreationAttributes>,
//     InforSectionAttributes {
//   createdAt?: Date;
//   updatedAt?: Date;
// }

// const InforSection = sequelize.define<InforSectionInstance>("InforSection", {
//   id: {
//     allowNull: false,
//     autoIncrement: true,
//     primaryKey: true,
//     type: DataTypes.INTEGER,
//   },
//   title: {
//     type: DataTypes.STRING,
//     allowNull: false,
//   },
//   content: {
//     type: DataTypes.TEXT,
//   },
// });

// export default InforSection;
