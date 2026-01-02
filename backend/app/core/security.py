from http.client import HTTPException
from fastapi import Depends
from passlib.context import CryptContext
from jose import JWTError, jwt
from datetime import datetime, timedelta
from fastapi.security import OAuth2PasswordBearer
import os

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")  #Kontekst za heširanje lozinki koristeći bcrypt algoritam
oauth_2_scheme = OAuth2PasswordBearer(tokenUrl="auth/login")  #OAuth2 šema za autentifikaciju putem tokena

def verify_password(plain_password: str, hashed_password: str) -> bool:
    return pwd_context.verify(plain_password, hashed_password)  #Funkcija za verifikaciju lozinke

def hash_password(password: str) -> str:
    return pwd_context.hash(password)  #Funkcija za heširanje lozinke

SECRET_KEY = os.getenv("SECRET_KEY")  #Tajni ključ za JWT token
if not SECRET_KEY:
    raise ValueError("SECRET_KEY environment variable is not set")
ALGORITHM = "HS256"  #Algoritam za potpisivanje JWT tokena
ACCESS_TOKEN_EXPIRE_MINUTES = 15  #Vreme isteka tokena u minutima

def get_current_user(token: str = Depends(oauth_2_scheme)): #Funkcija za dobijanje trenutnog korisnika iz JWT tokena
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM]) 
        username: str = payload.get("sub")
        role: str = payload.get("Uloga")
        if username is None:
            raise HTTPException(status_code=401, detail="Invalid token")
        return {"username": username, "role": role}  
    except JWTError:
        raise HTTPException(status_code=401, detail="Invalid token")
    
def create_access_token(data: dict, expires_delta: timedelta = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM) #Funkcija za kreiranje JWT tokena