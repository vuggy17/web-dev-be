import { deleted, invalidInput, notFound, publish } from "@shared/constants";
import { StatusCodes } from "http-status-codes";
import { Op } from "sequelize";
import HttpError from "@helper/iHttpError";
import Comment, {
  CommentAttributes,
  CommentInstance,
} from "@src/models/BlogComment";
import BlogDao from "./Blog";
import Blog from "@src/models/Blog";

const blogDao = new BlogDao();

class CommentDao {
  public async create(
    blogId: number,
    data: CommentAttributes
  ): Promise<CommentInstance> {
    const blog = await Blog.findOne({
      where: {
        id: blogId,
        status: publish,
      },
    });

    if (blog == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    const comment = Comment.create({
      ...data,
      blog_id: Number(blog.id),
    });
    return comment;
  }

  public async edit(
    id: number,
    data: CommentAttributes
  ): Promise<CommentInstance> {
    const comment = await Comment.findByPk(id);
    if (comment == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    await comment?.update({
      ...data,
      repliedAt: data.reply ? new Date().toString() : data.repliedAt,
    });
    return comment;
  }

  public async delete(id: number): Promise<void> {
    const comment = await Comment.findByPk(id);
    if (comment == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    await comment?.destroy();
  }

  public async getAllCommentOfBlog(
    blogId: number,
    is_show: boolean | null
  ): Promise<any> {
    let whereSearch: { is_show?: boolean } = {};
    if (is_show != null) whereSearch["is_show"] = is_show;

    const blog = await Blog.findOne({
      where: {
        id: blogId,
        status: { [Op.not]: deleted },
      },
      attributes: ["title", "id", "path"],
      include: [
        {
          model: Comment,
          where: {
            ...whereSearch,
          },
          as: "comments",
          order: [["updatedAt", "DESC"]],
        },
      ],
    });

    return blog;
  }

  public async getComments(is_show: boolean | null): Promise<any[]> {
    const whereSearch: { is_show?: boolean } = {};
    if (is_show != null) whereSearch["is_show"] = is_show;

    const list = await Blog.findAll({
      attributes: ["title", "id", "path"],
      include: [
        {
          model: Comment,
          required: true,
          where: {
            ...whereSearch,
          },
          as: "comments",
          order: [["updatedAt", "DESC"]],
        },
      ],
    });
    return list;
  }
}

export default CommentDao;
