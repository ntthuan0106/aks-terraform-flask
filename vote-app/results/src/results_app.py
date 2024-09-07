from flask import Flask, render_template
import pyodbc
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

results_app = Flask(__name__)

# Azure SQL connection parameters
DRIVER = "{ODBC Driver 18 for SQL Server}"
SERVER = os.getenv("SERVER")
DATABASE = os.getenv("DATABASE")
UID = os.getenv("UID")
PWD = os.getenv("PWD")

connection_string = (
    f"DRIVER={DRIVER};"
    f"SERVER={SERVER};"
    f"DATABASE={DATABASE};"
    f"UID={UID};"
    f"PWD={PWD}"
)

# Establish the database connection
conn = pyodbc.connect(connection_string)

@results_app.route('/')
def display_results():
    cursor = conn.cursor()
    cursor.execute("SELECT id, choice FROM votes")
    rows = cursor.fetchall()
    results = [{'id': row.id, 'choice': row.choice} for row in rows]
    return render_template('result.html', results=results)

if __name__ == '__main__':
    results_app.run(debug=True,port=5001)
