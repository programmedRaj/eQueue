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

import user_apis as user_side
import eqbiz as eqbiz
import eqadmin as eqadmin
import equser as equser
import string
import random


def allowedd_file(filename):
    ALLOWED_EXTENSIONS = set(["pdf", "jpg", "jpeg", "png"])
    return "." in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS


def create_branch(
    bname,
    pnum,
    addr1,
    addr2,
    city,
    postalcode,
    geolocation,
    province,
    comp_id,
    w_hrs,
    services,
    timezone,
    notify_time,
    bpd,
    bphrs,
    filename,
    threshold,
    department,
):
    conn = mysql.connect()
    cur = conn.cursor(pymysql.cursors.DictCursor)
    cur2 = conn.cursor(pymysql.cursors.DictCursor)
    try:
        if request.form["acc_type"] == "booking":
            q = (
                "INSERT INTO branch-details(bname,phone_number,address1,address2,city,postalcode,geolocation,province,comp_id,working_hours,services,timezone,notify_time,booking_per_day,per_day_hours,profile_photo_url,money_earned) VALUES ('"
                + str(bname)
                + "','"
                + str(pnum)
                + "','"
                + str(addr1)
                + "','"
                + str(addr2)
                + "','"
                + str(city)
                + "','"
                + str(postalcode)
                + "','"
                + str(geolocation)
                + "','"
                + str(province)
                + "',"
                + str(comp_id)
                + ",'"
                + str(w_hrs)
                + "','"
                + str(services)
                + "','"
                + str(timezone)
                + "','"
                + str(notify_time)
                + "','"
                + str(bpd)
                + "','"
                + str(bphrs)
                + "','"
                + str(filename)
                + "','0');"
            )

        elif request.form["acc_type"] == "token":
            q = (
                "INSERT INTO branch-details(bname,pnum,addr1,addr2,city,postalcode,geolocation,province,comp_id,w_hrs,department,threshold,filename,money_earned) VALUES ('"
                + str(bname)
                + "','"
                + str(pnum)
                + "','"
                + str(addr1)
                + "','"
                + str(addr2)
                + "','"
                + str(city)
                + "','"
                + str(postalcode)
                + "','"
                + str(geolocation)
                + "','"
                + str(province)
                + "',"
                + str(comp_id)
                + ",'"
                + str(w_hrs)
                + "','"
                + str(department)
                + "','"
                + str(threshold)
                + "','"
                + str(filename)
                + "','0');"
            )
        elif request.form["acc_type"] == "multitoken":
            q = (
                "INSERT INTO branch-details(bname,pnum,addr1,addr2,city,postalcode,geolocation,province,comp_id,w_hrs,department,threshold,filename,money_earned) VALUES ('"
                + str(bname)
                + "','"
                + str(pnum)
                + "','"
                + str(addr1)
                + "','"
                + str(addr2)
                + "','"
                + str(city)
                + "','"
                + str(postalcode)
                + "','"
                + str(geolocation)
                + "','"
                + str(province)
                + "',"
                + str(comp_id)
                + ",'"
                + str(w_hrs)
                + "','"
                + str(department)
                + "','"
                + str(threshold)
                + "','"
                + str(filename)
                + "','0');"
            )

        fire = str(q)
        print(fire)
        check = cur2.execute(fire)
        if check:
            return 200
        return 403

    finally:
        cur.close()
        cur2.close()
        conn.close()


def edit_branch(
    bname,
    pnum,
    addr1,
    addr2,
    city,
    postalcode,
    geolocation,
    province,
    comp_id,
    w_hrs,
    services,
    timezone,
    notify_time,
    bpd,
    bphrs,
    filename,
    threshold,
    department,
):
    conn = mysql.connect()
    # email = request.form["email"]
    emp_id = request.form["company_id"]

    cur = conn.cursor(pymysql.cursors.DictCursor)
    try:
        check = cur.execute(
            "SELECT * from companydetails" + " WHERE id = " + str(emp_id) + ";"
        )
        if check:
            records = cur.fetchone()
            print(records["id"])
            if request.files["company_logo"]:
                company_logo = request.files["company_logo"]
                filename = secure_filename(company_logo.filename)
                company_logo.save(os.path.join(app.config["UPLOAD_FOLDER"], filename))
            else:
                filename = records["profile_url"]
            print(filename)
            if request.form["acc_type"] == "booking":
                name = request.form["name"]
                desc = request.form["desc"]
                bank_name = request.form["bankname"]
                ifsc = request.form["ifsc_code"]
                account_number = request.form["accountnumber"]
                account_name = request.form["accountname"]
                q = (
                    "UPDATE companydetails SET name = '"
                    + str(name)
                    + "',profile_url = '"
                    + str(filename)
                    + "',descr = '"
                    + str(desc)
                    + "',bank_name='"
                    + str(bank_name)
                    + "',ifsc='"
                    + str(ifsc)
                    + "',account_number='"
                    + str(account_number)
                    + "',account_name='"
                    + str(account_name)
                    + "' WHERE id ="
                    + str(emp_id)
                    + ";"
                )
            elif request.form["acc_type"] == "token":
                name = request.form["name"]
                desc = request.form["desc"]
                q = (
                    "UPDATE companydetails SET name = '"
                    + str(name)
                    + "',profile_url = '"
                    + str(filename)
                    + "',descr = '"
                    + str(desc)
                    + "';"
                )
            elif request.form["acc_type"] == "multitoken":
                name = request.form["name"]
                desc = request.form["desc"]
                oneliner = request.form["oneliner"]
                q = (
                    "UPDATE companydetails SET name = '"
                    + str(name)
                    + "',profile_url = '"
                    + str(filename)
                    + "',descr = '"
                    + str(desc)
                    + "',oneliner = '"
                    + str(oneliner)
                    + "';"
                )
            else:
                resp = jsonify({"message": "INVALID company type."})
                resp.status_code = 405
                return resp

            if check:
                print(q)
                check = cur.execute(q)
                resp = jsonify({"message": "successfully added."})
                resp.status_code = 200
                conn.commit()
                return resp
            resp = jsonify({"message": "Error."})
            resp.status_code = 403
            return resp
        else:
            resp = jsonify({"message": "No Company Found."})
            resp.status_code = 403
            return resp

    finally:
        cur.close()
        conn.close()


def delete_branch():
    conn = mysql.connect()
    emp_id = request.json["company_id"]
    cur = conn.cursor(pymysql.cursors.DictCursor)
    try:
        check = cur.execute(
            "SELECT * from companydetails WHERE id =" + str(emp_id) + " ;"
        )
        if check:
            checkk = cur.execute(
                "SELECT * from bizusers WHERE id =" + str(emp_id) + " ;"
            )
            if checkk:
                check = cur.execute(
                    "DELETE FROM companydetails WHERE id =" + str(emp_id) + " ;"
                )
                check = cur.execute(
                    "DELETE FROM bizusers WHERE id =" + str(emp_id) + " ;"
                )
                conn.commit()
                resp = jsonify({"message": "Deleted successfully."})
                resp.status_code = 200
                return resp
            resp = jsonify({"message": "No Company found with this name."})
            resp.status_code = 403
            return resp
        resp = jsonify({"message": "No Company found with this name."})
        resp.status_code = 403
        return resp

    finally:
        cur.close()
        conn.close()
