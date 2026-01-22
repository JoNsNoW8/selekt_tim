from fastapi import APIRouter, Depends
from app.core.security import get_current_worker

router = APIRouter(prefix="/users", tags=["users"])

@router.get("/profil") 
def get_worker_profile(current_worker: dict = Depends(get_current_worker)):
    return {"username": current_worker["username"], "uloga": current_worker["uloga"]}