import "../pre-start";
import { Sequelize, Dialect } from "sequelize";

const sequelize = new Sequelize({
  host: String(process.env.DB_HOST),
  database: String(process.env.DB_NAME),
  username: String(process.env.DB_USERNAME),
  password: String(process.env.DB_PASSWORD),
  dialect: "mysql",
});

// sequelize.sync({ alter: true, force: false });

export { Sequelize, sequelize };
