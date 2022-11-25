import { OrderInstance } from "../../models/Order";
import { sendMail } from "./mailService";
import fs from "fs";
import { OrderItemInstance } from "@src/models/OrderItem";
import { replaceTemplate } from "@helper/string";
import path from "path";
import moment from "moment";
import { BlogInstance } from "@src/models/Blog";
import { SubscribeInstance } from "@src/models/Subscribe";

moment.locale("vi");

export default async function sendMailBlog(
  blog: BlogInstance,
  mails: SubscribeInstance[]
) {
  const template = fs
    .readFileSync(path.resolve(__dirname, "../../public/template/blog-notification.html"))
    .toString();

  const content = [
    { key: "title", value: blog.title },
    { key: "description", value: blog.description },
    {
      key: "thumbnail",
      value: process.env.IMAGE_HOST + blog.feature_image,
    },
    { key: "url", value: process.env.WEBSITE + "/blogs/" + blog.path },
  ];

  const mailContent = replaceTemplate(template, content);

  for (let i = 0; i < mails.length; i++) {
    let current = mails[i];
    sendMail({
      template: mailContent,
      to: current.email,
      title: blog.title,
      subject: blog.title,
      text: blog.description,
      content: [],
    });
  }
}
