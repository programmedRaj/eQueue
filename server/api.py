# -*- coding: utf-8 -*-
"""
Created on Tue Jun 23 17:56:30 2020

@author: user
"""
import json
import pymysql
import jwt
import datetime
import requests
from app import app
from db_config import mysql
from flask import jsonify
from flask import flash, request, session, make_response, render_template, Response
from werkzeug.security import generate_password_hash, check_password_hash
from functools import wraps
from flask_cors import CORS

from werkzeug.utils import secure_filename
import os
import jsonpickle
import numpy as np
import no_auth_apis as no_auth

import user_apis as user_side


CORS(app)

# ADMIN SIDE REQUESTS.


def check_for_token(param):
    @wraps(param)
    def wrapped(*args, **kwargs):
        token = ""
        if "Authorization" in request.headers:
            token = request.headers["Authorization"]
        # token = request.args.get('token')
        if not token:
            return jsonify({"message": "Missing Token"}), 403
        try:
            data = jwt.decode(token, app.config["SECRET_KEY"])
            # can use this data to fetch current user with contact number encoded in token
        except:
            return jsonify({"message": "Invalid Token"}), 403
        return param(*args, **kwargs)

    return wrapped


# Get current active user
# @app.route("/user")
@check_for_token
def user():
    token = request.headers["Authorization"]
    username = jwt.decode(token, app.config["SECRET_KEY"])
    response = user_side.user(username)
    return response


# @app.route("/register", methods=["POST"])
# def register():
#     username = request.json("username")
#     email = request.json("email")
#     password = request.json("password")
#     password_hash = generate_password_hash(password)
#     # account = Table("account", metadata, autoload=True)
#     # engine.execute(
#     #     account.insert(), username=username, email=email, password=password_hash
#     # )
#     return jsonify({"user_added": True})


@app.route("/adminsign_in", methods=["POST"])
def sign_in():
    conn = mysql.connect()
    cur = conn.cursor(pymysql.cursors.DictCursor)
    try:
        username_entered = request.json["email"]
        password_entered = request.json["password"]
        check = cur.execute(
            "Select * FROM user WHERE email ='" + str(username_entered) + "';"
        )
        if check:
            r = cur.fetchall()
            for i in r:
                if check_password_hash(i["password"], password_entered):
                    resp = jsonify({"message": True})
                    resp.status_code = 200
                    return resp
                else:
                    resp = jsonify({"message": False})
                    resp.status_code = 403
                    return resp
        return jsonify({"message": "No users Found."})
    finally:
        cur.close()
        conn.close()


# @app.route("/news", methods=["POST"])
# @check_for_token
# def news():
#     token = request.headers["Authorization"]
#     user = jwt.decode(token, app.config["SECRET_KEY"])
#     conn = mysql.connect()
#     cur = conn.cursor(pymysql.cursors.DictCursor)
#     cur2 = conn.cursor(pymysql.cursors.DictCursor)
#     try:
#         check = cur.execute(
#             "Select * FROM customer WHERE id ='" + str(user["user_id"]) + "';"
#         )
#         if check:
#             cur2.execute(
#                 "Select * FROM news WHERE category ='"
#                 + str(request.json["category"])
#                 + "';"
#             )
#             newsss = cur2.fetchall()
#             lists_h = []
#             lists_d = []
#             lists_i = []
#             lists_t = []
#             # print(newsss)
#             for i in newsss:
#                 lists_h.append(i["headline"])
#                 lists_d.append(i["Desc"])
#                 lists_i.append(i["img"])
#                 lists_t.append(i["tag"])
#             resp = jsonify(
#                 {
#                     "headline": lists_h,
#                     "desc": lists_d,
#                     "img": lists_i,
#                     "tag": lists_t,
#                 }
#             )
#             resp.status_code = 200
#             conn.commit()
#             return resp
#         resp = jsonify({"message": "No News Found."})
#         resp.status_code = 403
#         return resp
#     finally:
#         cur.close()
#         cur2.close()
#         conn.close()


# @app.route("/new_txn", methods=["POST"])
# @check_for_token
# def new_txn():
#     token = request.headers["Authorization"]
#     user = jwt.decode(token, app.config["SECRET_KEY"])
#     conn = mysql.connect()
#     status_txn = request.json["status_txn"]
#     txnid = request.json["txnid"]
#     amnt = request.json["amnt"]
#     cur = conn.cursor(pymysql.cursors.DictCursor)
#     cur2 = conn.cursor(pymysql.cursors.DictCursor)
#     try:
#         if status_txn != "success":
#             check = cur.execute(
#                 "INSERT INTO transactions (customer_id,status,color,transactions_amt,transaction_id) VALUES ("
#                 + str(user["user_id"])
#                 + ",'"
#                 + str(status_txn)
#                 + "','red','"
#                 + str(amnt)
#                 + "','"
#                 + str(txnid)
#                 + "');"
#             )
#             if check:
#                 resp = jsonify(
#                     {"message": "successfully added but was for failed transaction."}
#                 )
#                 resp.status_code = 201  # success but failed txn tha.
#                 conn.commit()
#                 return resp
#             resp = jsonify({"message": "Error in Query."})
#             resp.status_code = 403
#             return resp

#         check = cur.execute(
#             "INSERT INTO transactions (customer_id,status,color,transactions_amt,transaction_id) VALUES ("
#             + str(user["user_id"])
#             + ",'"
#             + str(status_txn)
#             + "','green','"
#             + str(amnt)
#             + "','"
#             + str(txnid)
#             + "');"
#         )

#         checko = cur.execute(
#             "SELECT id,money_wallet FROM customer WHERE ( id = '"
#             + str(user["user_id"])
#             + "');"
#         )

#         if checko:
#             records = cur.fetchall()
#             for r in records:
#                 bonus = r["money_wallet"]

#             if check:
#                 checkk = cur2.execute(
#                     "UPDATE customer SET money_wallet="
#                     + str(float(bonus) + amnt)
#                     + " WHERE id = "
#                     + str(user["user_id"])
#                     + ";"
#                 )
#                 if checkk:
#                     resp = jsonify({"message": "SUCCESS."})
#                     resp.status_code = 200
#                     conn.commit()
#                     return resp
#                 resp = jsonify({"message": "ERROR occured."})
#                 resp.status_code = 403
#                 return resp
#         resp = jsonify({"message": "ERROR occured."})
#         resp.status_code = 403
#         return resp
#     finally:
#         cur.close()
#         cur2.close()
#         conn.close()


# @app.route("/banners", methods=["POST"])
# @check_for_token
# def banners():
#     conn = mysql.connect()
#     cur = conn.cursor(pymysql.cursors.DictCursor)
#     try:

#         if request.json["type"] == "slider":
#             cur.execute("Select * FROM banners WHERE  type='slider' ;")
#         if request.json["type"] == "promote":
#             cur.execute("Select * FROM banners WHERE  type='promote' ;")
#         else:
#             resp = jsonify({"message": "INVALID request."})
#             resp.status_code = 403
#             return resp

#         banners = cur.fetchall()
#         if matches:
#             resp = jsonify({"banners": banners})
#             resp.status_code = 200
#             conn.commit()
#             return resp
#         resp = jsonify({"message": "No banners."})
#         resp.status_code = 404  # no banners
#         return resp
#     finally:
#         cur.close()
#         conn.close()


@app.errorhandler(404)
def not_found(error=None):
    message = {
        "status": 404,
        "message": "Not Found " + request.url,
    }

    resp = jsonify(message)
    resp.status_code = 404

    return resp


if __name__ == "__main__":
    app.run(debug=False)
