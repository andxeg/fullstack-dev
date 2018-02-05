import json
from flask import Flask
from flask_mysqldb import MySQL


app = Flask(__name__)
mysql = MySQL()

with open("config.json", "r") as f:
        config_dict = json.load(f)

db_config = config_dict['DATABASES'][0]

app.config['MYSQL_USER'] = db_config['user']
app.config['MYSQL_PASSWORD'] = db_config['password']
app.config['MYSQL_DB'] = db_config['db']
app.config['MYSQL_HOST'] = db_config['host']
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
