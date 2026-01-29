from sqlalchemy import Column, Integer, String, Date
from app.database.base import Base


class Vlasnik(Base):
    __tablename__ = "VLASNICI"
    
    SH_VLASNIKA = Column(String(4), primary_key=True)
    IME = Column(String(25))
    SH_MESTA = Column(String(5))
    ADRESA = Column(String(25))
    TELEFON1 = Column(String(10))
