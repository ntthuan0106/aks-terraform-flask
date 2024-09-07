from flask import Flask, render_template, request, redirect, url_for
import pyodbc
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

vote_app = Flask(__name__)

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

@vote_app.route('/', methods=['GET', 'POST'])
def vote():
    if request.method == 'POST':
        choice = request.form['vote']  # Assuming the form field is named 'vote'
        
        # Insert the vote into the database
        cursor = conn.cursor()
        cursor.execute("INSERT INTO votes (choice) VALUES (?)", choice)
        conn.commit()
    
    return render_template('vote.html')


if __name__ == '__main__':
    vote_app.run(debug=True)
