/* eslint-disable @typescript-eslint/restrict-template-expressions */
/* eslint-disable @typescript-eslint/no-unsafe-call */
import formatMoney from "@helper/number";
import { OrderInstance } from "@src/models/Order";
import fs, { PathLike } from "fs";
import moment from "moment";
import path from "path";
import PDFDocument from "pdfkit";

export default function createInvoice(order: OrderInstance) {
  const doc = new PDFDocument({ margin: 50 });
  const font = fs.readFileSync(path.resolve(__dirname, "../../public/assets/arial.ttf"));

  doc.font(font);

  generateHeader(doc);
  generateCustomerInformation(doc, order);
  generateInvoiceTable(doc, order);

  doc.end();

  const fileName =
    order.id.toString() + new Date().getTime().toString() + ".pdf";

  doc.pipe(
    fs.createWriteStream(path.resolve(__dirname, `../../../upload/${fileName}`))
  );
  return fileName;
}

function generateHeader(doc: any) {
  doc
    // .image("logo.png", 50, 45, { width: 50 })
    .fillColor("#444444")
    .fontSize(20)
    .text("DR ĐÔNG PHƯƠNG", 50, 57)
    .fontSize(10)
    .moveDown();
}

function generateFooter(doc: any, order: any, position: any) {
  doc
    .fontSize(10)
    .text("Tạm tính", 400, position + 30, { align: "right", width: 120 })
    .text(formatMoney(order.product_money), 490, position + 30, {
      align: "right",
      width: 90,
    })
    .text("Giảm giá", 400, position + 50, { align: "right", width: 120 })
    .text("-" + formatMoney(order.promotion_money ?? 0), 490, position + 50, {
      align: "right",
      width: 90,
    })
    .text("Tổng cộng", 400, position + 70, { align: "right", width: 120 })
    .text(formatMoney(order.total), 490, position + 70, {
      align: "right",
      width: 90,
    })
    .text("Khách hàng", 100, position + 130)
    .text("Người bán hàng", 400, position + 130)
    .text("Nguyễn Ngọc Đông Phương", 380, position + 150);
}

function generateInvoiceTable(doc: any, order: any) {
  let i,
    invoiceTableTop = 250;

  doc
    .fontSize(10)
    .text("STT", 50, invoiceTableTop)
    .text("Tên sản phẩm", 100, invoiceTableTop, { width: 150 })
    .text("Số lượng", 250, invoiceTableTop, { width: 90, align: "right" })
    .text("Đơn giá", 340, invoiceTableTop, { width: 90, align: "right" })
    .text("Khuyến mãi", 430, invoiceTableTop, { width: 90, align: "right" })
    .text("Thành tiền", 520, invoiceTableTop, { width: 90, align: "center" });

  invoiceTableTop = invoiceTableTop + 20;

  for (i = 0; i < order.items.length; i++) {
    const item = order.items[i];
    invoiceTableTop = invoiceTableTop + 30;
    if (item.variant_id == 0) {
      generateTableRow(
        doc,
        invoiceTableTop,
        i + 1,
        (item.product?.name ?? "").match(/.{1,45}/g).join("\n"),
        item.number,
        formatMoney(item.product?.price),
        "-" + formatMoney(item.discount),
        formatMoney(item.total - item.discount)
      );
    } else {
      generateTableRow(
        doc,
        invoiceTableTop,
        i + 1,
        (item.product!.name + " - " + item.ProductVariant?.name)!
          .match(/.{1,45}/g)!
          .join("\n"),
        item.number,
        formatMoney(item.ProductVariant?.price),
        "-" + formatMoney(item.discount),
        formatMoney(item.total - item.discount)
      );
    }
  }
  generateFooter(doc, order, invoiceTableTop);
}

function generateTableRow(
  doc: any,
  y: any,
  c1: any,
  c2: any,
  c3: any,
  c4: any,
  c5: any,
  c6: any
) {
  doc
    .fontSize(10)
    .text(c1, 50, y)
    .text(c2, 100, y, { width: 250 })
    .text(c3, 250, y, { width: 90, align: "right" })
    .text(c4, 340, y, { width: 90, align: "right" })
    .text(c5, 430, y, { width: 90, align: "right" })
    .text(c6, 520, y, { width: 90, align: "center" });
}

function generateCustomerInformation(doc: any, order: any) {
  const startY = 100;

  doc
    .fontSize(20)
    .text("Hoá đơn", 50, startY)
    .fontSize(10)
    .text(`Mã hoá đơn: ${order.id}`, 50, startY + 50)
    .text(`Khách hàng: ${order.customer_name}`, 50, startY + 65)
    .text(`Ngày lập: ${moment(order.createdAt).format("lll")}`, 50, startY + 80)
    .text(`Địa chỉ: ${order.address}`, 50, startY + 95)
    .moveDown();
}
