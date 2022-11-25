import { Model, Optional, DataTypes, CreateOptions } from "sequelize";
import { sequelize } from ".";
import Blog from "./Blog";

export interface CommentAttributes {
  id?: number;
  email: string;
  name: string;
  phone: string;
  content: string;
  is_show: boolean;
  blog_id: number;
  reply: string;
  repliedAt: string;
}

interface CommentCreationAttributes
  extends Optional<
    CommentAttributes,
    "id" | "is_show" | "reply" | "repliedAt"
  > {}

export interface CommentInstance
  extends Model<CommentAttributes, CommentCreationAttributes>,
    CommentAttributes {
  createdAt?: Date;
  updatedAt?: Date;
}

const Comment = sequelize.define<CommentInstance>("Comment", {
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: DataTypes.INTEGER,
  },
  email: {
    type: DataTypes.STRING,
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  phone: {
    type: DataTypes.STRING,
  },
  content: {
    type: DataTypes.TEXT,
    allowNull: false,
  },
  is_show: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
  blog_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  reply: {
    type: DataTypes.TEXT,
    allowNull: true,
  },
  repliedAt: {
    allowNull: true,
    type: DataTypes.DATE,
  },
});

Comment.belongsTo(Blog, {
  foreignKey: "blog_id",
  onDelete: "CASCADE",
  as: "blog",
});

Blog.hasMany(Comment, {
  foreignKey: "blog_id",
  as: "comments",
  onDelete: "CASCADE",
});

export default Comment;
