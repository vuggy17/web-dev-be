import { cancel, confirm, pending, shipping, success } from "@shared/constants";
import { sequelize } from "@src/models";
import Blog from "@src/models/Blog";
import Comment from "@src/models/BlogComment";
import Order, {
  OrderInstance
} from "@src/models/Order";
import Product from "@src/models/Product";
import Subscribe from "@src/models/Subscribe";
import { Op, QueryTypes } from "sequelize";



class AdminDao {
  private async getOrdersAnalytics(): Promise<any> {
    const countOrders: {
      all: number;
      pending: number;
      shipping: number;
      success: number;
      confirm: number;
      cancel: number;
    } = {
      all: 0,
      pending: 0,
      shipping: 0,
      success: 0,
      confirm: 0,
      cancel: 0
    };

    const res: any = await sequelize.query(`
    SELECT * 
    FROM Orders 
    WHERE MONTH(createdAt) = ${(new Date().getMonth() + 1)}`, { type: QueryTypes.SELECT });

    const orders: OrderInstance[] = res;
    orders.forEach(order => {
      switch (order.status) {
        case pending:
          countOrders.pending++;
          break;
        case success:
          countOrders.success++;
          break;
        case confirm:
          countOrders.confirm++;
          break;
        case shipping:
          countOrders.shipping++;
          break;
        case cancel:
          countOrders.cancel++;
          break;
        default:
          break;
      }
    })
    countOrders.all = orders.length;
    return countOrders;
  }

  public async getAnalytics(): Promise<any> {
    const countBlog = await Blog.count({
      where: {
        status: { [Op.not]: "deleted" },
      },
    });
    const countSubscribe = await Subscribe.count();
    // const countOrder = await Order.count({
    //   where: {
    //     status: {
    //       [Op.not]: "cancel",
    //     },
    //   },
    // });
    const countPendingOrder = await Order.count({
      where: {
        status: "pending",
      },
    });
    const countProduct = await Product.count();
    const countComment = await Comment.count();
    const countPendingComment = await Comment.count({
      where: {
        is_show: false,
      },
    });

    const countOrder = await this.getOrdersAnalytics();



    return {
      countBlog,
      countComment,
      countOrder,
      countPendingComment,
      countPendingOrder,
      countSubscribe,
      countProduct
    };
  }
}

export default AdminDao;
