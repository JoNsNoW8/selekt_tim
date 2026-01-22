from sqlalchemy import create_engine
from sqlalchemy import text
from sqlalchemy.orm import sessionmaker

DATABASE_URL = ("mssql+pyodbc://@DESKTOP-J08GUNA\\SQLEXPRESS/SelektTim"
    "?driver=ODBC+Driver+18+for+SQL+Server"
    "&trusted_connection=yes"
    "&TrustServerCertificate=yes") #Konekcioni string za BP

engine = create_engine(DATABASE_URL) #Kreiranje engine-a za konekciju sa BP
SessionLocal = sessionmaker(bind=engine) #Kreiranje sesije za rad sa BP


# Test konekcije


with engine.connect() as conn:
     result = conn.execute(text("SELECT 1"))
     print(result.fetchone())

