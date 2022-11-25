import { Model, Optional, DataTypes, CreateOptions } from "sequelize";
import { sequelize } from ".";
import Blog from "./Blog";

// Author.hasMany(Book, {
//   sourceKey: "id",
//   foreignKey: "authorId",
//   as: "books",
// });

// Book.belongsTo(Author, {
//   foreignKey: "authorId",
//   as: "author",
// });

// export default Author;

export interface MediaAttributes {
  id?: number;
  title: string;
  filename: string;
  filetype: string;
  alt: string;
  url: string;
  filesize: number;
  uploadBy: string;
}

interface MediaCreationAttributes
  extends Optional<MediaAttributes, "id" | "alt"> {}

export interface MediaInstance
  extends Model<MediaAttributes, MediaCreationAttributes>,
    MediaAttributes {
  createdAt?: Date;
  updatedAt?: Date;
}

const Media = sequelize.define<MediaInstance>(
  "Media",
  {
    id: {
      allowNull: false,
      autoIncrement: true,
      primaryKey: true,
      type: DataTypes.INTEGER,
    },
    title: {
      allowNull: false,
      type: DataTypes.STRING,
    },
    url: {
      type: DataTypes.STRING,
    },
    filename: {
      type: DataTypes.STRING,
      unique: true,
    },
    filetype: {
      type: DataTypes.STRING,
    },
    alt: {
      type: DataTypes.STRING,
    },
    filesize: {
      type: DataTypes.FLOAT,
    },
    uploadBy: {
      type: DataTypes.STRING,
    },
  },
  {
    paranoid: true,
  }
);

Media.addScope("public", {
  attributes: {
    exclude: ["filesize", "uploadBy", "createdAt", "updatedAt", "deletedAt"],
  },
});

export default Media;
