import { OrderInstance } from "./../../models/Order";
import { sendMail } from "./mailService";
import fs from "fs";
import { OrderItemInstance } from "@src/models/OrderItem";
import { replaceTemplate } from "@helper/string";
import path from "path";
import moment from "moment";
import formatMoney from "@helper/number";

moment.locale("vi");

export default async function sendMailConfirm(order: OrderInstance) {
  const template = fs
    .readFileSync(path.resolve(__dirname, "../../public/template/order-confirm.html"))
    .toString();

  // template: string;
  // to: string;
  // title?: string;
  // subject?: string;
  // text?: string;
  // content: { key: string; value: string }[];

  const itemTemplate = fs
    .readFileSync(
      path.resolve(__dirname, "../../public/template/order-item-template.html")
    )
    .toString();

  const tableData = order.items
    ?.map((item: OrderItemInstance) => {
      if (item.variant_id == 0) {
        return replaceTemplate(itemTemplate, [
          {
            key: "name",
            value: item.product?.name ?? "",
          },
          {
            key: "number",
            value: item.number.toString(),
          },
          {
            key: "price",
            value: (item.total).toString(),
          },
        ]);
      } else {
        return replaceTemplate(itemTemplate, [
          {
            key: "name",
            value: item.product!.name + " - " + item.ProductVariant?.name,
          },
          {
            key: "number",
            value: item.number.toString(),
          },
          {
            key: "price",
            value: formatMoney(item.total).toString(),
          },
        ]);
      }
    })
    .join("");

  await sendMail({
    template: template,
    to: order.customer_email,
    title: "Xác Nhận Đơn Hàng",
    subject: "Cảm ơn bạn đã mua hàng của chúng tôi!",
    text: "Cảm ơn bạn đã mua hàng của chúng tôi!",
    content: [
      { key: "number", value: order.id.toString() },
      { key: "date_time", value: moment(order.createdAt).format("lll") },
      { key: "customer_name", value: order.customer_name },
      { key: "product_money", value: formatMoney(order.product_money).toString() },
      { key: "promotion_money", value: formatMoney(order.promotion_money).toString() },
      { key: "total", value: formatMoney(order.total).toString() },
      { key: "items", value: String(tableData) },
    ],
  });
}
