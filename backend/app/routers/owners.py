from fastapi import APIRouter, Depends
from app.core.security import get_current_user

router = APIRouter(prefix="/users", tags=["users"])

@router.get("/profil") 
def get_user_profile(current_user: dict = Depends(get_current_user)):
    return {"username": current_user["username"], "uloga": current_user["uloga"]}