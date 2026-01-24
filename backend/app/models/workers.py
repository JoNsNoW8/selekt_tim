from sqlalchemy import Column, Integer, String
from app.database.base import Base


class Workers(Base):
    __tablename__ = "Radnici"

    RadnikID = Column(Integer, primary_key=True)
    ImeRadnika = Column(String(20))
    PrezimeRadnika = Column(String(20))
    Username = Column(String(20), nullable=False)
    PasswordHash = Column(String(255), nullable=False)
    Uloga = Column(String(20))
