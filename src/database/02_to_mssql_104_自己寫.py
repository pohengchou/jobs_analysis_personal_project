#conda install pyodbc sqlachemy

#步驟1:載入套件
import urllib.parse
import pandas as pd
from sqlalchemy import create_engine
import urllib

#步驟2:設定資料庫連線參數，並用urllib進行編碼
params=urllib.parse.quote_plus(
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=FMPC\\SQLEXPRESS;"
    "DATABASE=數據分析職缺_專題;"
    "Trusted_Connection=yes;"
    )
#步驟3:使用sqlalchemy建立引擎，與資料庫連線
engine=create_engine(f"mssql+pyodbc:///?odbc_connect={params}")

#步驟4:匯入資料
df=pd.read_csv("data/104_rawdata_2025-08-04.csv") 

df.to_sql("104_rawdata_2025-08-04",con=engine,if_exists="replace",index=False)  #這邊的"104_rawdata_2025-07-08"是想在資料庫顯示的名稱
print("🟢匯入完成!")