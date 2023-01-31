// import './pre-start'; // Must be the first import
import app from '@server';
import logger from '@shared/Logger';
import { sequelize } from './models';
<<<<<<< Updated upstream
// eslint-disable-next-line @typescript-eslint/no-unsafe-call, @typescript-eslint/no-var-requires
require('dotenv').config()
// Start the server
const port = Number(process.env.PORT || 3000);

sequelize
    .authenticate()
    .then(() => {
        logger.info('Connection has been established successfully.');
        app.listen(port, () => {
            logger.info('Express server started on port: ' + port);
        });

    })
    .catch(err => {
        console.error('Unable to connect to the database:', err);
    });
=======


// Start the server
const port = Number(process.env.PORT || 3000);
sequelize.authenticate().then(() => {
    app.listen(port, () =>
        logger.info('Express server started on port: ' + port)
    )
}).catch((error) =>
    console.error('Unable to connect to the database:', error)
);

>>>>>>> Stashed changes

