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


def user(naam):
    try:
        conn = mysql.connect()
        cur = conn.cursor(pymysql.cursors.DictCursor)
        cur.execute("Select * from customer WHERE id=" + str(naam["user_id"]) + ";")
        rows = cur.fetchall()
        resp = jsonify(rows)
        resp.status_code = 200
        return resp
    except Exception as e:
        print(e)
    finally:
        cur.close()
        conn.close()


def canceltb(type, uid, number, tok_booking_num, addmoney, tablename):
    try:
        conn = mysql.connect()
        cur = conn.cursor(pymysql.cursors.DictCursor)
        cur.execute(
            "DELETE FROM "
            + str(tablename)
            + " WHERE user_id='"
            + str(uid)
            + "' AND id = '"
            + str(number)
            + "';"
        )
        if type == "token":
            r = cur.execute(
                "DELETE FROM "
                + "tokenshistory WHERE branchtable='"
                + str(tablename)
                + "' AND user_id = '"
                + str(uid)
                + "' AND token = '"
                + str(tok_booking_num)
                + "';"
            )
            if r:
                return 200
            else:
                return 400

        else:
            r = cur.execute(
                "DELETE FROM "
                + "bookingshistory WHERE branchtable='"
                + str(tablename)
                + "' AND user_id = '"
                + str(uid)
                + "' AND booking = '"
                + str(tok_booking_num)
                + "';"
            )

            rr = cur.execute(
                "UPDATE user_details SET money = '"
                + str(addmoney)
                + "' WHERE id ='"
                + str(uid)
                + "';"
            )
            conn.commit()

            if r and rr:
                return 200
            else:
                return 400

    finally:
        cur.close()
        conn.close()
