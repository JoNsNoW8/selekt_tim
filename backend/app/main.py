from dotenv import load_dotenv

from app.routers import cows
load_dotenv()
from fastapi import FastAPI
from app.routers import auth
from app.routers import owners

app = FastAPI(title ="SelektTim API")

@app.get("/") #Root endpoint za proveravanje statusa API-ja
def root():
    return {"status" : "API is running"} #Root endpoint odgovor
    
app.include_router(auth.router) #Uključivanje auth rutera u glavnu aplikaciju
app.include_router(owners.router) 
app.include_router(cows.router) 