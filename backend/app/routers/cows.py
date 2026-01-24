from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database.session import SessionLocal
from app.models.cow import Grlo

router = APIRouter(prefix="/grla", tags=["grla"])


@router.get("/{ID_Grla}")
def get_grlo(ID_Grla: int, db: Session = Depends(SessionLocal)):
    return db.query(Grlo).filter(Grlo.ID_Grla == ID_Grla).first()
