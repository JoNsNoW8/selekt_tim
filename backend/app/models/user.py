from sqlalchemy import Column, Integer, String
from app.database.base import Base

class Users(Base):
    __tablename__ = "Users"

    UserID = Column(Integer, primary_key=True)
    Name = Column(String(30))
    Surname = Column(String(30))
    Username = Column(String(50), nullable=False)
    PasswordHash = Column(String(255), nullable=False)
    