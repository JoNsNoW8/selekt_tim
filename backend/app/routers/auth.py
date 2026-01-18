from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database.session import SessionLocal
from app.models.user import Users
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
    user = db.query(Users).filter(Users.Username == request.username).first()
    if not user or not verify_password(request.password, user.password_hash):
        raise HTTPException(status_code=400, detail="Pogresno korisnicko ime ili lozinka")

    token = create_access_token(data={"sub": user.Username, "role": user.Uloga})
    return {"access_token": token, "Uloga": user.Uloga}