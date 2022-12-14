// import "../pre-start";
import { Sequelize, Dialect } from "sequelize";
// eslint-disable-next-line @typescript-eslint/no-unsafe-call
require("dotenv").config()
const sequelize = new Sequelize({
  host: String(process.env.DB_HOST),
  port:parseInt(process.env.DB_PORT||"3306"),
  database: String(process.env.DB_NAME),
  username: String(process.env.DB_USERNAME),
  password: String(process.env.DB_PASSWORD),
  dialect: "postgres",
});
sequelize.sync({ alter: true,force:true });

export { Sequelize, sequelize };
