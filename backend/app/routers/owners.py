from fastapi import APIRouter, Depends
from app.core.security import get_current_worker

router = APIRouter(prefix="/owners", tags=["owners"])


@router.get("/profile")
def get_owner_profile(current_user: dict = Depends(get_current_worker)):
    return {"username": current_user["username"], "uloga": current_user["uloga"]}
