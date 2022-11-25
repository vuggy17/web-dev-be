import ProductDao from "../src/daos/Product/Product";
import { sequelize } from "../src/models/index"; // this will be your custom import
import { publish } from "../src/shared/constants";
import Product, {
  ProductCreationAttributes,
  ProductInstance,
} from "../src/models/Product";

import Order, {
  OrderCreationAttributes,
  OrderInstance,
} from "../src/models/Order";
import ProductCategory, {
  ProductCategoryInstance,
} from "../src/models/ProductCategory";
import ProductCategoryDao from "../src/daos/Product/ProductCategory";
import Blog, { BlogCreationAttributes, BlogInstance } from "../src/models/Blog";
import Comment, { CommentCreationAttributes } from "../src/models/BlogComment";
import BlogDao from "../src/daos/Blog/Blog";
import OrderDao from "../src/daos/Order/Order";
import CommentDao from "../src/daos/Blog/Comment";

const productDao = new ProductDao();
const productCategoryDao = new ProductCategoryDao();
const blogDao = new BlogDao();
const commentDao = new CommentDao();
const orderDao = new OrderDao();

beforeAll(async () => {
  // sequelize.sync({ alter: true, force: true });
  ProductCategory.destroy({
    where: {},
  });
  Product.destroy({
    where: {},
  });
  Order.destroy({ where: {} });
  Blog.destroy({ where: {} });
});

describe("Add comment", () => {
  let blog: BlogInstance = null;
  const newBlog: BlogCreationAttributes = {
    title: "New Blog Title 2",
    description: "Description of blog",
    path: "path-121231239s22",
    content: "content here",
    status: publish,
  };

  test("Add new comment", async () => {
    blog = await blogDao.create(newBlog);

    const newComment: CommentCreationAttributes = {
      name: "comment new",
      content: "hello",
      phone: "081231231",
      email: "19521110@gm.uit.edu.vn",
      blog_id: blog.id,
    };

    const result = await commentDao.create(blog.id, newComment);

    expect(result.content).toEqual(newComment.content);
  });

  test("Add new comment failed (not found)", async () => {
    try {
      const newComment: CommentCreationAttributes = {
        name: "Product 1",
        content: "hello",
        phone: "081231231",
        email: "19521110@gm.uit.edu.vn",
        blog_id: 2,
      };

      const result = await commentDao.create(2, newComment);
    } catch (err) {
      console.log(err);
      expect(err.status).toEqual(404);
    }
  });
});

describe("Place order", () => {
  let product: ProductInstance = null;
  let category: ProductCategoryInstance = null;

  const newProduct: ProductCreationAttributes = {
    name: "Product 12",
    category_id: null,
    thumbnail: null,
    price: 120000,
    SKU: "AABBSS",
    description: "Description of blog",
    path: "product-121231239s23",
    content: "content of product",
  };

  test("Place new order success", async () => {
    product = await productDao.create(newProduct);

    const newOrder: object = {
      customer_email: "19521110@gm.uit.edu.vn",
      customer_name: "Duong Cong Vu",
      phone: "+840212312",
      address: "Dong Nai",
      note: null,
      items: [
        {
          product_id: product.id,
          variant_id: 0,
          number: 2,
        },
      ],
    };

    const result = await orderDao.createOrder(newOrder);

    expect(result.product_money).toEqual(newProduct.price * 2);
  });
});
