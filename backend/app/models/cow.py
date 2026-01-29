from sqlalchemy import Column, ForeignKey, Integer, String, Date
from app.database.base import Base


class Grlo(Base):
    __tablename__ = "GRLA"
    
    IDG = Column(String(13), primary_key=True)
    SH_VLASNIKA = Column(String(4))
    TETOVIR_GR = Column(String(13))
    SH_MESTA = Column*(String(5)) #isto kao i vlasnik vrv
    DATUM = Column(Integer) #datum rodjenja krave ali je cuvano kao int
    
