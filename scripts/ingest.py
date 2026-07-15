import requests
import duckdb
import pandas as pd
from dotenv import load_dotenv
import os

load_dotenv()

API_KEY = os.getenv("FOOTBALL_API_KEY")
API_URL = "https://api.football-data.org/v4/competitions/PL/matches"

headers = {"X-Auth-Token": API_KEY}

# Fetch data from API
print("Fetching data from football-data.org...")
response = requests.get(API_URL, headers=headers)
response.raise_for_status()
data = response.json()

# Flatten into a DataFrame
matches = data["matches"]
df = pd.json_normalize(matches)

# Clean column names
df.columns = df.columns.str.replace(".", "_", regex=False).str.lower()

print(f"Fetched {len(df)} matches")
print(df.head())

# Load into DuckDB
con = duckdb.connect("../data/dev.duckdb")
con.execute("CREATE SCHEMA IF NOT EXISTS raw")
con.execute("DROP TABLE IF EXISTS raw.matches")
con.execute("CREATE TABLE raw.matches AS SELECT * FROM df")

print("Loaded into raw.matches in DuckDB")
con.close()