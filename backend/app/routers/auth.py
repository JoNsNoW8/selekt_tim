from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database.session import SessionLocal
from app.models.workers import Users
from app.core.security import verify_password, create_access_token, hash_password
from pydantic import BaseModel

router = APIRouter(prefix="/auth", tags=["auth"])

MASTER_INVITE_CODE = "SELEKTIM_2026"


class RegisterRequest(BaseModel):
    username: str
    password: str
    ime: str
    prezime: str
    invite_code: str


class LoginRequest(BaseModel):
    username: str
    password: str


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.post("/register")
async def register_worker(data: RegisterRequest, db: Session = Depends(get_db)):
    if data.invite_code != MASTER_INVITE_CODE:
        raise HTTPException(
            status_code=403, detail="Pogrešan pozivni kod. Obratite se administratoru."
        )
    existing_user = db.query(Users).filter(Users.Username == data.username).first()
    if existing_user:
        raise HTTPException(status_code=400, detail="Korisničko ime je zauzeto.")
    # Kreiranje novog ranika
    new_user = Users(
        ImeRadnika=data.ime,
        PrezimeRadnika=data.prezime,
        Username=data.username,
        PasswordHash=hash_password(data.password),
        Uloga="worker",  # Default uloga
    )

    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    return {"message": "Registracija uspešna!"}


@router.post("/login")
def login(request: LoginRequest, db: Session = Depends(get_db)):
    print(f"DEBUG: Attempting login for username: {request.username}")

    user = db.query(Users).filter(Users.Username == request.username).first()

    if not user:
        print("DEBUG: User not found in database")
        raise HTTPException(status_code=400, detail="Korisnik ne postoji")

    print(f"DEBUG: User found. Comparing passwords...")
    is_valid = verify_password(request.password, user.PasswordHash)

    if not is_valid:
        print(f"DEBUG: Password mismatch for user {user.Username}")
        raise HTTPException(status_code=400, detail="Pogrešna lozinka")

    print("DEBUG: Login successful!")
    token = create_access_token(data={"sub": user.Username, "role": user.Uloga})
    return {
        "access_token": token,
        "Uloga": user.Uloga,
        "ImeRadnika": user.ImeRadnika,
        "PrezimeRadnika": user.PrezimeRadnika,
    }
