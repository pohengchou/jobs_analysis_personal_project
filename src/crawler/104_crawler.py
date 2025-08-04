import requests
import time
import random
import pandas as pd
from datetime import datetime 
import os  
import ast

#先F12開啟開發者模式，確認參數
keywords_list = ["數據分析", "數據工程", "數據科學","資料分析", "資料工程", "資料科學","BI"]

url="https://www.104.com.tw/jobs/search/api/jobs"

params={
    "jobsource":"m_joblist_search",
    "keyword":"",    #先留空 之後動態改變
    "mode":"s",
    "order":15,
    "page":"",
    "pagesize":20,
}

headers={
    "User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36",
    "Referer":"https://www.104.com.tw/",
}


# ✅ 白名單：只保留這些職缺名稱關鍵字的職缺
WHITELIST_KEYWORDS = [
    # 中文職稱
    "資料分析", "數據分析", "資料科學", "數據科學", 
    "資料工程", "數據工程", "商業分析", "商業智慧", 
    "統計分析", "資料科學家", "資料工程師", "商業分析師", 
    "數據科學家", "數據工程師",

    # 英文職稱
    "data analyst", "data analytics", "data analysis", 
    "data scientist", "data science", "data engineer", 
    "business analyst", "business intelligence", 
    "bi analyst", "bi developer"
]


# ❌ 黑名單：排除這些明顯不相關的職缺
EXCLUDE_WORDS = ["助理", "客服", "門市", "儲備幹部", "工讀", "講師", "作業員", "行政", "業務", "外包", "設計"]

def is_relevant_job(title):
    title=title.lower()
    return any(good in title for good in WHITELIST_KEYWORDS) and not any(bad in title for bad in EXCLUDE_WORDS)

#---第二層爬蟲---所需參數與函數
detail_headers={
    "User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36",
    "Referer":"", #先留空
    "X-Requested-With": "XMLHttpRequest",
}
def fetch_job_detail(first_layer_data):
    link_data = first_layer_data["link"]
    print(f"Link data: {link_data}")  # 確認link_data的原始格式

    # 如果 link_data 已經是字典格式，直接使用它；如果是字串，則解析它
    if isinstance(link_data, str):
        try:
            link_data = ast.literal_eval(link_data)
        except Exception as e:
            print(f"解析連結資料錯誤: {e}")
            return None
    job_url = link_data["job"]
    job_no = job_url.strip("/").split("/")[-1]
    detail_url = f"https://www.104.com.tw/job/ajax/content/{job_no}"

    detail_headers_current=detail_headers.copy()
    detail_headers_current["Referer"]=link_data["job"]
    response=requests.get(url=detail_url,headers=detail_headers_current, timeout=15)
    detail_data = response.json()
    return detail_data["data"]


#開始請求回傳資料
all_data=[]  #將蒐集的資料存在這個空list當中
for keywords in keywords_list:
    page=1
    max_page=100
    while page <= max_page:
        try:
            params["keyword"]=keywords
            params["page"]=page
            print(f"🔍 抓取「{keywords}」第 {page} 頁")
            response=requests.get(url=url,params=params,headers=headers)
            data=response.json()
            filter_jobs=[job for job in data["data"] if is_relevant_job(job["jobName"])] 
            detail_data_all=[]
            for item in filter_jobs:   #合併第一層與第二層資料
                detail_data =fetch_job_detail(item)
                if detail_data:
                    merge_record={**item,**detail_data}
                    merge_record["search_keyword"] = keywords
                    all_data.append(merge_record)
                else:
                    item["search_keyword"] = keywords
                    all_data.append(item)

            time.sleep(random.uniform(1.5,3.5)) #模擬人操作，隨機時間間隔換頁
            page+=1
        except Exception as e:
            print(e)
            print("錯誤，解析json失敗!!")
            break

#將回傳內容儲存成檔案
df=pd.DataFrame(all_data)  
today=datetime.today().strftime("%Y-%m-%d")
filename=f"104_rawdata_{today}.csv"
folder=r"C:\Users\FM_pc\Desktop\jobs_analysis_project\data"
os.makedirs(folder,exist_ok=True)  #確保資料夾存在，無則建立
df.to_csv(os.path.join(folder,filename),index=False,encoding="utf-8-sig",quoting=1)
print(f"爬蟲完成，儲存成{filename}")
