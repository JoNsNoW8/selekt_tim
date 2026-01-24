from sqlalchemy import Column, Integer, String
from app.database.base import Base


class Promene(Base):
    __tablename__ = "FRPOMENE"
