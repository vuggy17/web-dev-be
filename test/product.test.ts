import ProductDao from "../src/daos/Product/Product";
import { sequelize } from "../src/models/index"; // this will be your custom import
import { publish } from "../src/shared/constants";
import Product, {
  ProductCreationAttributes,
  ProductInstance,
} from "../src/models/Product";
import ProductCategory, {
  ProductCategoryInstance,
} from "../src/models/ProductCategory";
import ProductCategoryDao from "../src/daos/Product/ProductCategory";

const productDao = new ProductDao();
const productCategoryDao = new ProductCategoryDao();

beforeAll(async () => {
  // sequelize.sync({ alter: true, force: true });
  ProductCategory.destroy({
    where: {},
  });
  Product.destroy({
    where: {},
  });
});

describe("Create product", () => {
  let product: ProductInstance = null;
  let category: ProductCategoryInstance = null;
  test("Create new product success", async () => {
    category = await productCategoryDao.create({
      name: "category-test",
      description: "test content",
    });

    const newProduct: ProductCreationAttributes = {
      name: "Product 1",
      category_id: category.id,
      thumbnail: null,
      price: 120000,
      SKU: "AABBSS",
      description: "Description of blog",
      path: "product-121231239s2",
      content: "content of product",
    };

    product = await productDao.create(newProduct);

    expect(product.name).toEqual(newProduct.name);
  });

  test("Create new product failed (null value)", async () => {
    try {
      const newProduct: ProductCreationAttributes = {
        name: "Product 2",
        category_id: category.id,
        thumbnail: null,
        price: null,
        SKU: "AABBSS1",
        description: "Description of blog",
        path: "product-2",
        content: "content of product",
      };

      product = await productDao.create(newProduct);
    } catch (err) {
      expect(err.toString()).toMatch("Validation error");
    }
  });

  test("Create new product failed (invalid input)", async () => {
    try {
      const newProduct: ProductCreationAttributes = {
        name: "Product 3",
        category_id: category.id,
        thumbnail: null,
        price: -20000,
        SKU: "AABBSS1",
        description: "Description of blog",
        path: "product-3",
        content: "content of product",
      };

      product = await productDao.create(newProduct);
    } catch (err) {
      expect(err.toString()).toMatch("Validation error");
    }
  });
});

describe("Get product", () => {
  test("Get product detail success", async () => {
    const findBlog = await productDao.find("product-121231239s2");
    expect(findBlog.path).toEqual("product-121231239s2");
  });

  test("Get product detail not found", async () => {
    try {
      const findBlog = await productDao.find("product-not-found");
      expect(findBlog.path).toEqual("product-not-found");
    } catch (err) {
      expect(err.status).toEqual(404);
    }
  });
});

describe("Edit product", () => {
  test("Edit product success", async () => {
    const newPrice = 12221;
    const result = await productDao.edit("product-121231239s2", {
      price: newPrice,
    });
    expect(result.price).toEqual(newPrice);
  });

  test("Edit product failed (not found)", async () => {
    try {
      const newPrice = 12221;
      const result = await productDao.edit("random-path", {
        price: newPrice,
      });
    } catch (err) {
      expect(err.status).toEqual(404);
    }
  });

  test("Edit product failed (invalid input)", async () => {
    try {
      const newPrice = -12200;
      const result = await productDao.edit("product-121231239s2", {
        price: newPrice,
      });
    } catch (err) {
      expect(err.toString()).toMatch("Validation error");
    }
  });
});

describe("Delete product", () => {
  test("Delete product success", async () => {
    try {
      await productDao.delete("product-121231239s2");
      const findProduct = await productDao.find("product-121231239s2");
    } catch (err) {
      expect(err.status).toEqual(404);
    }
  });

  test("Delete product failed (not found)", async () => {
    try {
      await productDao.delete("product-not-found");
    } catch (err) {
      expect(err.status).toEqual(404);
    }
  });
});
