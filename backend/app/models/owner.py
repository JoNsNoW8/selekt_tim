from sqlalchemy import Column, Integer, String, Date
from app.database.base import Base

class Vlasnik(Base):
    __tablename__ = "K_VLASNICI"

    ID_Vlasnika = Column(Integer, primary_key=True)
    ImeVlasnika = Column(String(50))
    PrezimeVlasnika = Column(String(50))
    BrGazdinstva = Column(Integer)
