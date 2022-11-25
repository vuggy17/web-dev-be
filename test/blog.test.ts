import BlogDao from "../src/daos/Blog/Blog";
import { sequelize } from "../src/models/index"; // this will be your custom import
import { BlogAttributes, BlogCreationAttributes } from "../src/models/Blog";

const blogDao = new BlogDao();

describe("Blog management", () => {
  test("Create new blog", async () => {
    const newBlog: BlogCreationAttributes = {
      title: "hello2",
      description: "description",
      path: "path-121231239s2",
      content: "content here",
    };
    const result = await blogDao.create(newBlog);

    expect(result.title).toEqual(newBlog.title);
  });
});
