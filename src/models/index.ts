// import "../pre-start";
import { Sequelize, Dialect } from "sequelize";
// eslint-disable-next-line @typescript-eslint/no-unsafe-call
require("dotenv").config();
const sequelize = new Sequelize({
  host: String(process.env.DB_HOST),
  port: parseInt(process.env.DB_PORT || "3306"),
  database: String(process.env.DB_NAME),
  username: String(process.env.DB_USERNAME),
  password: String(process.env.DB_PASSWORD),
  dialect: "postgres",
});

<<<<<<< Updated upstream
// sequelize.sync({ alter: true,force:true });
=======
// sequelize.sync({ alter: true, force: false }); // turn force to true and uncomment to recreate db on startup

>>>>>>> Stashed changes
export { Sequelize, sequelize };
