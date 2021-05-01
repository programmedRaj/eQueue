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
            "UPDATE "
            + str(tablename)
            + " SET status = 'cancelled' WHERE user_id='"
            + str(uid)
            + "' AND id = '"
            + str(number)
            + "';"
        )
        conn.commit()
        cur = conn.cursor(pymysql.cursors.DictCursor)

        if type == "token":
            r = cur.execute(
                "UPDATE tokenshistory SET status = 'cancelled' WHERE branchtable='"
                + str(tablename)
                + "' AND user_id = '"
                + str(uid)
                + "' AND token = '"
                + str(tok_booking_num)
                + "';"
            )
            conn.commit()

            if r:
                return 200
            else:
                return 400

        else:
            r = cur.execute(
                "UPDATE bookingshistory SET status = 'cancelled' WHERE branchtable='"
                + str(tablename)
                + "' AND user_id = '"
                + str(uid)
                + "' AND booking = '"
                + str(tok_booking_num)
                + "';"
            )
            conn.commit()
            cur = conn.cursor(pymysql.cursors.DictCursor)

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
