from app import app
from flaskext.mysql import MySQL

mysql = MySQL()

# MySQL configurations
app.config["MYSQL_DATABASE_USER"] = "admin_root"
# app.config["MYSQL_DATABASE_USER"] = "root"
app.config["MYSQL_DATABASE_PASSWORD"] = "RS$5%kJs@!!2"
# app.config["MYSQL_DATABASE_PASSWORD"] = "root"
app.config["MYSQL_DATABASE_DB"] = "admin_equeue"
# app.config["MYSQL_DATABASE_DB"] = "equeue"
app.config["MYSQL_DATABASE_HOST"] = "localhost"
app.config["MYSQL_DATABASE_PORT"] = 3306
# app.config["MYSQL_DATABASE_PORT"] = 3306

mysql.init_app(app)
