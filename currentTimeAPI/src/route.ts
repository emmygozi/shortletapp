import express, { Request, Response, NextFunction } from 'express';
import { format } from 'date-fns';


const app = express.Router();

app.get('/', (request: Request, response: Response) => response.status(200).send('Welcome to Shortlet App'));

app.get('/current-time', (request: Request, response: Response) => { 
    const now = new Date();
    const formattedDate = format(now, "yyyy-MM-dd'T'HH:mm:ssXXX");
    const timeObject = { currentTime: formattedDate };
    return response.json(timeObject); 
});

app.use((request: Request, response: Response, next: NextFunction) => {
    const error = new Error('Not Found');
    (error as any).status = 404;
    next(error);
  });
  
  app.use((error: any, request: Request, response: Response, next: NextFunction) => {
    response.status(error.status || 500);
    response.json({
      error: {
        message: error.message,
      },
    });
  });

export default app;