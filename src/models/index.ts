// import "../pre-start";
import { Sequelize, Dialect } from "sequelize";

const sequelize = new Sequelize({
  host: String(process.env.DB_HOST),
  port:parseInt(process.env.DB_PORT||"3306"),
  database: String(process.env.DB_NAME),
  username: String(process.env.DB_USERNAME),
  password: String(process.env.DB_PASSWORD),
  dialect: "postgres",
});

export { Sequelize, sequelize };
