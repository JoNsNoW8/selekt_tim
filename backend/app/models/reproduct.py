from sqlalchemy import Column, ForeignKey, Integer, String, Date
from app.database.base import Base


class Osmenjavanje(Base):
    __tablename__ = "OSEMEN"
    
    IDG = Column(String(13), primary_key=True)
    BIK_OS = Column(String(20)) #hb broj bika koji je osemenio kravu
    DAUM_O = Column(Integer) #datum osemenjavanja ali je cuvano kao int
    
