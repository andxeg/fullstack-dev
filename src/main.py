import json
from flask import Flask
from flask_mysqldb import MySQL


app = Flask(__name__)
mysql = MySQL()

with open("confi.json", "r") as f:
	config_dict = json.load(f)

app.config['MYSQL_USER'] = config_dict['user']
app.config['MYSQL_PASSWORD'] = config_dict['password']
app.config['MYSQL_DB'] = config_dict['db']
app.config['MYSQL_HOST'] = config_dict['host']
mysql.init_app(app)


@app.route("/test_db")
def test_db():
    cur = mysql.connection.cursor()
    cur.execute('''select * from potluck''')
    rv = cur.fetchall()
    return str(rv)

@app.route("/test")
def teams():
    return "Test!"

@app.route("/")
def hello():
    return "Hello World!"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)