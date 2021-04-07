# -*- coding: utf-8 -*-
"""
Created on Tue Jun 23 17:45:11 2020

@author: user
"""

from app import app
from flaskext.mysql import MySQL

mysql = MySQL()

# MySQL configurations
app.config["MYSQL_DATABASE_USER"] = "root"
app.config["MYSQL_DATABASE_PASSWORD"] = "root"
app.config["MYSQL_DATABASE_DB"] = "equeue"
app.config["MYSQL_DATABASE_HOST"] = "localhost"
app.config["MYSQL_DATABASE_PORT"] = 3306

mysql.init_app(app)
