// import './pre-start'; // Must be the first import
import app from '@server';
import logger from '@shared/Logger';
import { sequelize } from './models';


// Start the server
const port = Number(process.env.PORT || 3000);
sequelize.authenticate().then(() => {
    app.listen(port, () =>
        logger.info('Express server started on port: ' + port)
    )
}).catch((error) =>
    console.error('Unable to connect to the database:', error)
);


