import { blogStatus, deleted, edit, publish } from "@shared/constants";
import { generateSlug } from "@shared/functions";
import { Model, Optional, DataTypes, CreateOptions } from "sequelize";
import { sequelize } from ".";
import Category, { CategoryAttributes, CategoryInstance } from "./Category";
import Media from "./Media";
import Product from "./Product";
import Tag, { TagInstance } from "./Tag";

export interface BlogAttributes {
  id?: number;
  title: string;
  status: string;
  path: string;
  content: string;
  visible: boolean;
  last_publish: string;
  feature_image: string;
  description: string;
  allow_comment: boolean;
  view: number;
  stick_to_top: boolean;
  send_mail: boolean;
  category?: any;
  tag?: any;
  product?: any;
}

export interface BlogCreationAttributes
  extends Optional<
    BlogAttributes,
    | "id"
    | "allow_comment"
    | "stick_to_top"
    | "visible"
    | "status"
    | "last_publish"
    | "feature_image"
    | "view"
    | "send_mail"
  > {}

export interface BlogInstance
  extends Model<BlogAttributes, BlogCreationAttributes>,
    BlogAttributes {
  createdAt?: Date;
  updatedAt?: Date;
  category?: any;
  tag?: any;
  addProduct: Function;
  removeProduct: Function;
  getProduct: Function;
  addCategory: Function;
  removeCategory: Function;
  getCategory: Function;
  addTag: Function;
  removeTag: Function;
  getTag: Function;
}

const Blog = sequelize.define<BlogInstance>("Blog", {
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
  status: {
    type: DataTypes.ENUM(...blogStatus),
    allowNull: false,
    defaultValue: edit,
  },
  path: {
    type: DataTypes.STRING,
    unique: true,
  },
  content: {
    type: DataTypes.TEXT,
    allowNull: false,
  },
  visible: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
  last_publish: {
    type: DataTypes.DATE,
  },
  feature_image: {
    allowNull: true,
    type: DataTypes.STRING,
  },
  description: {
    type: DataTypes.TEXT,
  },
  allow_comment: {
    type: DataTypes.BOOLEAN,
    defaultValue: true,
  },
  stick_to_top: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
  view: {
    type: DataTypes.INTEGER,
    defaultValue: 0,
  },
  send_mail: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
});

Blog.belongsTo(Media, {
  foreignKey: "feature_image",
  targetKey: "filename",
  as: "media",
  onDelete: "SET NULL",
});

Blog.belongsToMany(Product, {
  through: "Blog_Product",
  as: "product",
  // onDelete: "SET NULL",
});

Product.belongsToMany(Blog, {
  through: "Blog_Product",
  as: "blog",
  // onDelete: "SET NULL",
});

Blog.belongsToMany(Tag, {
  through: "Blog_Tag",
  as: "tag",
  // onDelete: "SET NULL",
});

Tag.belongsToMany(Blog, {
  through: "Blog_Tag",
});

Blog.belongsToMany(Category, {
  through: "Blog_Category",
  // onDelete: "SET NULL",
  as: "category",
});

Category.belongsToMany(Blog, {
  through: "Blog_Category",
  // onDelete: "SET NULL",
});

Blog.beforeSave((instance: BlogInstance) => {
  if (instance.status == publish) instance.last_publish = new Date().toString();
  if (!instance.path) instance.path = generateSlug(instance.title);
});

Blog.beforeDestroy((instance: BlogInstance) => {
  const deleteTime = new Date().getTime();
  instance.path = instance.path + "-deleted-" + deleteTime;
  instance.title = instance.title + "-deleted-" + deleteTime;
});

Blog.addScope("public", {
  where: {
    status: publish,
  },
  attributes: {
    exclude: ["updatedAt", "deletedAt", "allow_comment"],
  },
  include: [
    {
      model: Category.scope("public"),
      as: "category",
      through: { attributes: [] },
      required: false,
    },
    {
      model: Tag.scope("public"),
      as: "tag",
      through: { attributes: [] },
      required: false,
    },
    {
      model: Media.scope("public"),
      as: "media",
      required: false,
    },
  ],
});

Blog.addScope("withCategory", {
  include: [
    {
      model: Category,
      as: "category",
      through: { attributes: [] },
      required: false,
    },
  ],
});

Blog.addScope("withTag", {
  include: [
    {
      model: Tag,
      as: "tag",
      through: { attributes: [] },
      required: false,
    },
  ],
});

Blog.addScope("withProduct", {
  include: [
    {
      model: Product,
      as: "product",
      through: { attributes: [] },
      required: false,
    },
  ],
});

Blog.addScope("withMedia", {
  include: [
    {
      model: Media,
      as: "media",
      required: false,
    },
  ],
});

export default Blog;
