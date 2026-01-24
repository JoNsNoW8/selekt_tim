from sqlalchemy import Column, ForeignKey, Integer, String, Date
from app.database.base import Base


class Grlo(Base):
    __tablename__ = "GRLA"

    ID_Grla = Column(Integer, primary_key=True)
    ID_Majke = Column(Integer)
    Kvalitet_mleka = Column(String(50), nullable=False)
    Datum_osemenjavanja = Column(Date)
    Datum_teljenja = Column(Date)
    Datum_rodjenja = Column(Date)
    ID_Vlasnika = Column(Integer, ForeignKey("Vlasnik.ID_Vlasnika"))
