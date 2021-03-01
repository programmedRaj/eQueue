import pymysql
import jwt
import datetime
import requests
from app import app
from db_config import mysql
from flask import jsonify
from flask import flash, request, session, make_response, render_template, Response
from functools import wraps
from flask_cors import CORS
import random
import string


# def test():
#     conn = mysql.connect()
#     cur = conn.cursor(pymysql.cursors.DictCursor)
#     cur.execute("SELECT email FROM customer;")
#     records = cur.fetchall()
#     lists = []
#     for r in records:
#         lists.append(r["email"])
#     resp = jsonify({"bonus": lists})
#     return resp
