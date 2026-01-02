from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database.session import SessionLocal
from app.models.user import Korisnik
from app.core.security import verify_password, create_access_token
from pydantic import BaseModel

#Login endpoint

router = APIRouter(prefix="/auth", tags=["auth"])

class LoginRequest(BaseModel):
    username: str
    password: str

def get_db(): 
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/login")
def login(request: LoginRequest, db: Session = Depends(get_db)):
    korisnik = db.query(Korisnik).filter(Korisnik.korisnickoIme == request.username).first()
    if not korisnik or not verify_password(request.password, korisnik.password_hash):
        raise HTTPException(status_code=400, detail="Pogresno korisnicko ime ili lozinka")
    
    token = create_access_token(data={"sub": korisnik.korisnickoIme, "Uloga": korisnik.Uloga})
    return {"access_token": token, "Uloga": korisnik.Uloga}