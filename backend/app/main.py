from fastapi import FastAPI
from dotenv import load_dotenv

from app.routers import auth, cows, owners

load_dotenv()


app = FastAPI(title="SelektTim API")


@app.get("/")  # Root endpoint za proveravanje statusa API-ja
def root():
    return {"status": "API is running"}  # Root endpoint odgovor


app.include_router(auth.router)  # Uključivanje auth rutera u glavnu aplikaciju
app.include_router(owners.router)
app.include_router(cows.router)