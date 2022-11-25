import { OrderInstance } from "./../../models/Order";
import { sendMail } from "./mailService";
import fs from "fs";
import { OrderItemInstance } from "@src/models/OrderItem";
import { replaceTemplate } from "@helper/string";
import path from "path";
import moment from "moment";

moment.locale("vi");

export default async function sendMailShipping(order: OrderInstance) {
  const template = fs
    .readFileSync(path.resolve(__dirname, "../../public/template/order-shipping.html"))
    .toString();

  await sendMail({
    template: template,
    to: order.customer_email,
    title: "Đơn hàng của bạn đang được vận chuyển",
    subject: "Đơn hàng của bạn đang được vận chuyển!",
    text: "Đơn hàng đã thanh toán thành công và đang được vận chuyển đến bạn trong thời gian nhanh nhất. Cảm ơn bạn đã mua hàng!",
    content: [
      { key: "number", value: order.id.toString() },
      { key: "date_time", value: moment(order.createdAt).format("lll") },
      { key: "customer_name", value: order.customer_name },
      { key: "customer_address", value: order.address },
    ],
  });
}
