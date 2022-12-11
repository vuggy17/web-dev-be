// import './pre-start'; // Must be the first import
import app from '@server';
import logger from '@shared/Logger';
// eslint-disable-next-line @typescript-eslint/no-unsafe-call, @typescript-eslint/no-var-requires
require("dotenv").config();
// Start the server
const port = Number(process.env.PORT || 3000);
app.listen(port, () => {
    logger.info('Express server started on port: ' + port);
});
