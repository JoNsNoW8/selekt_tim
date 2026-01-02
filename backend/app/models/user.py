from sqlalchemy import Column, Integer, String
from app.database.base import Base

class Korisnik(Base):
    __tablename__ = "Korisnik"

    ID_Korisnik = Column(Integer, primary_key=True)
    ImeKorisnika = Column(String(50))
    PrezimeKorisnika = Column(String(50))
    Uloga = Column(String(50))
    korisnickoIme = Column(String(20), unique=True, index=True)
    password_hash = Column(String(255))
    