import bcrypt
from dotenv import load_dotenv
from fastapi import HTTPException, Depends
from passlib.context import CryptContext
from jose import JWTError, jwt
from datetime import datetime, timedelta
from fastapi.security import OAuth2PasswordBearer
import os

load_dotenv()  # Učitavanje promenljivih okruženja iz .env fajla

pwd_context = CryptContext(
    schemes=["bcrypt"], deprecated="auto"
)  # Kontekst za heširanje lozinki koristeći bcrypt algoritam
oauth_2_scheme = OAuth2PasswordBearer(
    tokenUrl="auth/login"
)  # OAuth2 šema za autentifikaciju putem tokena


def verify_password(plain_password: str, hashed_password: str) -> bool:
    password_bytes = plain_password.encode("utf-8")
    hashed_bytes = hashed_password.encode("utf-8")
    return bcrypt.checkpw(password_bytes, hashed_bytes)


def hash_password(password: str) -> str:
    pwd_bytes = password.encode("utf-8")
    salt = bcrypt.gensalt()
    hashed = bcrypt.hashpw(pwd_bytes, salt)
    return hashed.decode("utf-8")


SECRET_KEY = os.getenv("SECRET_KEY")  # Tajni ključ za JWT token
if not SECRET_KEY:
    raise ValueError("SECRET_KEY environment variable is not set")
ALGORITHM = "HS256"  # Algoritam za potpisivanje JWT tokena
ACCESS_TOKEN_EXPIRE_MINUTES = 60  # Vreme isteka tokena u minutima


def get_current_worker(
    token: str = Depends(oauth_2_scheme),
):  # Funkcija za dobijanje trenutnog korisnika iz JWT tokena
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
    return jwt.encode(
        to_encode, SECRET_KEY, algorithm=ALGORITHM
    )  # Funkcija za kreiranje JWT tokena
