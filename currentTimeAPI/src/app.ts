import express from 'express';
import { log } from './debugConfig'; 
import { config } from 'dotenv';
import apis from './route';

config();


const app = express();
const port = process.env.PORT || 3000;

app.use('/api/v1', apis);



app.listen(port, () => {
    log(`Listening from port ${port}`);
});

export default app;