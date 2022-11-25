import { orderStatus } from "./../../shared/constants";
import HttpError from "@helper/iHttpError";
import { notFound } from "@shared/constants";
import { sequelize } from "@src/models";
import Customer from "@src/models/Customer";
import Order, {
  OrderAttributes,
  OrderCreationAttributes,
  OrderInstance,
} from "@src/models/Order";
import OrderItem from "@src/models/OrderItem";
import Product from "@src/models/Product";
import ProductVariant from "@src/models/ProductVariant";
import { StatusCodes } from "http-status-codes";
import { Op } from "sequelize";
import sendMailConfirm from "@helper/mailService/sendMailConfirm";
import sendMailShipping from "@helper/mailService/sendMailShipping";
import createInvoice from "@helper/invoice/generateInvoice";

class OrderDao {
  public async createOrder(
    data: OrderCreationAttributes
  ): Promise<OrderInstance | null> {
    const result = await sequelize.transaction(async (t) => {
      let total_product_money = 0;
      let total_promotion_money = 0;
      let total = 0;
      let this_product_money = 0;

      const order = await Order.create(
        {
          customer_email: data.customer_email,
          customer_name: data.customer_name,
          phone: data.phone,
          address: data.address,
          product_money: total_product_money,
          promotion_money: total_promotion_money,
          total: total,
          note: data.note,
        },
        {
          transaction: t,
        }
      );

      const calcMoney = data.items!.map(async (item: any) => {
        let discount = 0;
        if (item.variant_id == 0) {
          const product = await Product.findOne({
            where: {
              id: item.product_id,
              is_in_stock: true,
            },
          });
          if (!product)
            throw new HttpError(
              StatusCodes.NOT_FOUND,
              "Không tìm thấy sản phẩm hoặc đã hết hàng!"
            );

          if (product.is_on_sale) {
            let eachDiscount = product.price * product.discount;
            if (eachDiscount >= product.maxDiscount)
              eachDiscount = product.maxDiscount;
            discount = item.number * eachDiscount;
          }

          this_product_money = product.price * item.number;

          total_product_money = total_product_money + this_product_money;
          total_promotion_money = total_promotion_money + discount;
          total = total + this_product_money - discount;
        } else {
          const variant = await ProductVariant.findOne({
            where: {
              id: item.variant_id,
            },
            include: [
              {
                model: Product,
                where: {
                  is_in_stock: true,
                },
                required: true,
              },
            ],
          });

          if (!variant)
            throw new HttpError(
              StatusCodes.NOT_FOUND,
              "Không tìm thấy sản phẩm hoặc đã hết hàng! variant"
            );

          const product = variant.Product;

          if (product.is_on_sale) {
            let eachDiscount = variant.price * product.discount;
            if (eachDiscount >= product.maxDiscount)
              eachDiscount = product.maxDiscount;
            discount = item.number * eachDiscount;
          }

          this_product_money = variant.price * item.number;

          total_product_money = total_product_money + this_product_money;
          total_promotion_money = total_promotion_money + discount;
          total = total + this_product_money - discount;
        }

        await OrderItem.create(
          {
            product_id: item.product_id,
            variant_id: item.variant_id == 0 ? 0 : item.variant_id,
            order_id: order.id,
            number: item.number,
            discount: discount,
            total: this_product_money,
          },
          { transaction: t }
        );
      });

      await Promise.all(calcMoney);

      await order.update(
        {
          product_money: total_product_money,
          promotion_money: total_promotion_money,
          total: total,
        },
        { transaction: t }
      );
      // console.log('udpate xong')

      // const insertItem = data.items!.map(async (item: any) => {
      //   await OrderItem.create(
      //     {
      //       product_id: item.product_id,
      //       variant_id: item.variant_id == 0 ? 0 : item.variant_id,
      //       order_id: order.id,
      //       number: item.number,
      //       discount: 0,
      //       total: 0,
      //     },
      //     { transaction: t }
      //   );
      // });

      // await Promise.all(insertItem);

      return order;
    });
    return result;
  }

  public async search(
    statusQuery: string | "",
    customer_name: string | null,
    customer_email: string | null
  ): Promise<OrderInstance[]> {
    const findQuery: {
      status?: string;
      customer_name?: string;
      customer_email?: string;
    } = {};

    if (statusQuery) findQuery["status"] = statusQuery;
    if (customer_name) findQuery["customer_name"] = `%${customer_name}%`;
    if (customer_email) findQuery["customer_email"] = `%${customer_email}%`;

    const list = await Order.findAll({
      where: {
        ...findQuery,
      },
      order: [["createdAt", "DESC"]],
    });
    return list;
  }

  public async getDetail(id: number): Promise<OrderInstance> {
    const order = await this.getFullOrderInfo(id);

    return order!;
  }

  public async editOrder(
    id: number,
    data: OrderAttributes
  ): Promise<OrderInstance | null> {
    let order = await Order.findOne({
      where: {
        id: id,
      },
    });
    if (!order) throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    await order.update({ ...data });

    return order;
  }

  public async sendMailConfirm(id: number): Promise<OrderInstance | null> {
    const order = await this.getFullOrderInfo(id);
    if (order) await sendMailConfirm(order);

    await order!.update({ mail_confirm: true });

    return order;
  }

  public async sendMailShipping(id: number): Promise<OrderInstance | null> {
    const order = await this.getFullOrderInfo(id);

    if (order) await sendMailShipping(order);

    await order!.update({ mail_shipping: true });

    return order;
  }

  public async getFullOrderInfo(id: number): Promise<OrderInstance | null> {
    const associate = OrderItem.belongsTo(ProductVariant.scope("public"), {
      foreignKey: "variant_id",
    });

    let order = await Order.findOne({
      where: {
        id: id,
      },
      include: [
        {
          model: OrderItem,
          as: "items",
          include: [
            {
              model: Product,
              as: "product",
              paranoid: false,
              attributes: [
                "id",
                "name",
                "thumbnail",
                "price",
                "is_in_stock",
                "is_track_inventory",
                "SKU",
                "discount",
                "is_on_sale",
                "path",
              ],
            },
            {
              model: ProductVariant,
              association: associate,
            },
          ],
        },
      ],
    });
    if (!order) throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    return order;
  }

  public async getInvoice(id: number): Promise<String | undefined> {
    const order = await this.getFullOrderInfo(id);

    if (order) {
      if (order.invoice_name) return order.invoice_name;
      const filename = await createInvoice(order);
      await order!.update({ invoice_name: filename });
      return filename;
    }
  }
}

export default OrderDao;
