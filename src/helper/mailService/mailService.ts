import HttpError from "@helper/iHttpError";
import { replaceTemplate } from "@helper/string";
/* eslint-disable @typescript-eslint/no-unsafe-call */
// import { HttpException } from '@/exceptions/HttpException';
import { StatusCodes } from "http-status-codes";
import nodemailer from "nodemailer";

export interface SendMailInterface {
  template: string;
  to: string;
  title?: string;
  subject?: string;
  text?: string;
  content: { key: string; value: string }[];
}

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.MAIL_USER,
    pass: process.env.MAIL_PASS,
  },
});

export async function sendMail(data: SendMailInterface) {
  try {
    if (data.content.length > 0)
      data.template = replaceTemplate(data.template, data.content);

    const info = await transporter.sendMail({
      from: process.env.MAIL_USER, // sender address
      to: data.to, // list of receivers
      subject: data.subject, // Subject line
      text: data.text, // plain text body
      html: data.template, // html body
    });
  } catch (err) {
    console.log(err);
    throw new HttpError(
      StatusCodes.INTERNAL_SERVER_ERROR,
      "Hệ thống không thể gửi mail xác nhận, liên hệ admin để xử lí!"
    );
  }
}

// const mailData: SendMailInterface = {
//   to: '19521110@gm.uit.edu.vn',
//   template: `[[name]]`,
//   subject: 'Xác nhận đăng ký',
//   content: [{ key: 'name', value: 'Cong vu' }],
// };

// sendMail(mailData)
//   .then(res => console.log('thanh cong'))
//   .catch(err => console.log(err));
