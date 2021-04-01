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

import user_apis as user_side
import eqbiz as eqbiz
import eqadmin as eqadmin
import equser as equser
import string
import random


CORS(app)

# ADMIN SIDE REQUESTS.


def check_for_admin_token(param):
    @wraps(param)
    def wrapped(*args, **kwargs):
        token = ""
        if "Authorization" in request.headers:
            token = request.headers["Authorization"]
        # token = request.args.get('token')
        if not token:
            return jsonify({"message": "Missing Token"}), 403
        try:
            data = jwt.decode(token, app.config["ADMIN_SECRET_KEY"])
            # can use this data to fetch current user with contact number encoded in token
        except:
            return jsonify({"message": "Invalid Token"}), 403
        return param(*args, **kwargs)

    return wrapped


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


def check_for_user_token(param):
    @wraps(param)
    def wrapped(*args, **kwargs):
        token = ""
        if "Authorization" in request.headers:
            token = request.headers["Authorization"]
        # token = request.args.get('token')
        if not token:
            return jsonify({"message": "Missing Token"}), 403
        try:
            data = jwt.decode(token, app.config["USER_SECRET_KEY"])
            # can use this data to fetch current user with contact number encoded in token
        except:
            return jsonify({"message": "Invalid Token"}), 403
        return param(*args, **kwargs)

    return wrapped


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
                    token = jwt.encode(
                        {
                            "email": request.json["email"],
                            "id": i["id"],
                            "username": i["username"],
                            "exp": datetime.datetime.utcnow()
                            + datetime.timedelta(minutes=43200),
                        },
                        app.config["ADMIN_SECRET_KEY"],
                    )
                    resp = jsonify({"message": True, "token": token.decode("utf-8")})
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


def allowedd_file(filename):
    ALLOWED_EXTENSIONS = set(["pdf", "jpg", "jpeg", "png"])
    return "." in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS


@app.route("/create_company", methods=["POST"])
@check_for_admin_token
def create_company():
    conn = mysql.connect()
    email = request.form["email"]
    password = generate_password_hash(request.form["password"])
    cur = conn.cursor(pymysql.cursors.DictCursor)
    cur2 = conn.cursor(pymysql.cursors.DictCursor)
    try:
        company_logo = request.files["company_logo"]
        filename = secure_filename(company_logo.filename)
        company_logo.save(os.path.join(app.config["UPLOAD_FOLDER"], filename))
        if request.form["acc_type"] == "booking":
            name = request.form["name"]
            desc = request.form["desc"]
            bank_name = request.form["bankname"]
            ifsc = request.form["ifsc_code"]
            account_number = request.form["accountnumber"]
            account_name = request.form["accountname"]
            q = "INSERT INTO companydetails(id,name,profile_url,descr,bank_name,ifsc,account_number,account_name,type) VALUES ('"
            query = (
                "','"
                + str(name)
                + "','"
                + str(filename)
                + "','"
                + str(desc)
                + "','"
                + str(bank_name)
                + "','"
                + str(ifsc)
                + "','"
                + str(account_number)
                + "','"
                + str(account_name)
                + "','booking');"
            )
        elif request.form["acc_type"] == "token":
            name = request.form["name"]
            desc = request.form["desc"]
            q = "INSERT INTO companydetails (id,name,profile_url,descr,type) VALUES ('"
            query = (
                "','"
                + str(name)
                + "','"
                + str(str(filename))
                + "','"
                + str(desc)
                + "','token');"
            )
        elif request.form["acc_type"] == "multitoken":
            name = request.form["name"]
            desc = request.form["desc"]
            oneliner = request.form["oneliner"]
            q = "INSERT INTO companydetails (id,name,profile_url,descr,oneliner,type) VALUES ("
            query = (
                ",'"
                + str(name)
                + "','"
                + str(filename)
                + "','"
                + str(desc)
                + "','"
                + str(oneliner)
                + "','multitoken');"
            )
        else:
            resp = jsonify({"message": "INVALID company type."})
            resp.status_code = 405
            return resp

        check = cur.execute("Select * FROM bizusers WHERE email ='" + str(email) + "';")
        if check:
            resp = jsonify({"message": "Already taken."})
            resp.status_code = 405
            return resp
        else:
            check = cur.execute(
                "INSERT INTO bizusers (type,email,password,comp_type,status) VALUES ('company'"
                + ",'"
                + str(email)
                + "','"
                + str(password)
                + "','"
                + str(request.form["acc_type"])
                + "',"
                + "1);"
            )

            if check:
                fire = str(q) + str(cur.lastrowid) + str(query)
                print(fire)
                check = cur2.execute(fire)
                resp = jsonify({"message": "successfully added."})
                resp.status_code = 200
                conn.commit()
                return resp
            resp = jsonify({"message": "Error."})
            resp.status_code = 403
            return resp

    finally:
        cur.close()
        cur2.close()
        conn.close()


@app.route("/change_passw_admin", methods=["POST"])
@check_for_admin_token
def change_passw_admin():
    conn = mysql.connect()
    cur = conn.cursor(pymysql.cursors.DictCursor)
    password_entered = request.json["password"]
    n_password_entered = generate_password_hash(request.json["new_password"])
    token = request.headers["Authorization"]
    user = jwt.decode(token, app.config["ADMIN_SECRET_KEY"])
    try:
        check = cur.execute(
            "Select * FROM user WHERE email ='"
            + str(user["email"])
            + "' AND id = '"
            + str(user["id"])
            + "';"
        )
        if check:
            records = cur.fetchall()
            for r in records:
                if check_password_hash(r["password"], password_entered):
                    cur.execute(
                        "UPDATE user SET password = '"
                        + str(n_password_entered)
                        + "' WHERE email = '"
                        + str(user["email"])
                        + "';"
                    )
                    conn.commit()
                    resp = jsonify({"message": "success"})
                    resp.status_code = 200
                    return resp
                resp = jsonify({"message": "wrong old password."})
                resp.status_code = 403
                return resp
        resp = jsonify({"message": "No Admin Found."})
        resp.status_code = 405
        return resp
    finally:
        cur.close()
        conn.close()


@app.route("/companies")
@check_for_admin_token
def active_companies():
    conn = mysql.connect()
    cur = conn.cursor(pymysql.cursors.DictCursor)
    try:
        check = cur.execute("Select * FROM companydetails;")
        if check:
            records = cur.fetchall()
            check = cur.execute("Select email,status,created_on FROM bizusers;")
            if check:
                recordss = cur.fetchall()
                resp = jsonify({"companies": records, "comp_emails_status": recordss})
                resp.status_code = 200
                return resp
            resp = jsonify({"message": "no companies details found."})
            resp.status_code = 403
            return resp
        resp = jsonify({"message": "no companies found."})
        resp.status_code = 403
        return resp

    finally:
        cur.close()
        conn.close()


@app.route("/disable_company", methods=["POST"])
@check_for_admin_token
def disable_company():
    conn = mysql.connect()
    email = request.json["email"]
    emp_id = request.json["company_id"]
    disable = request.json["disable"]

    cur = conn.cursor(pymysql.cursors.DictCursor)
    try:
        check = cur.execute(
            "SELECT * from bizusers"
            + " WHERE email = '"
            + str(email)
            + "' AND id ="
            + str(emp_id)
            + " ;"
        )
        if check:
            if disable == 0:
                check = cur.execute(
                    "UPDATE bizusers SET status = 1 WHERE id =" + str(emp_id) + ";"
                )
                conn.commit()
                resp = jsonify({"message": "Updated successfully."})
                resp.status_code = 200
                return resp
            else:
                check = cur.execute(
                    "UPDATE bizusers SET status = 0 WHERE id =" + str(emp_id) + ";"
                )
                conn.commit()
                resp = jsonify({"message": "Updated successfully."})
                resp.status_code = 200
                return resp
        resp = jsonify({"message": "No Company Found."})
        resp.status_code = 403
        return resp

    finally:
        cur.close()
        conn.close()


@app.route("/edit_company", methods=["POST"])
@check_for_admin_token
def edit_company():
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


@app.route("/delete_company", methods=["POST"])
@check_for_admin_token
def delete_company():
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


def id_generator(size=6, chars=string.ascii_uppercase + string.digits):
    return "".join(random.choice(chars) for _ in range(size))


# BIZ APIs starts here..


@app.route("/biz_signin", methods=["POST"])
def biz_signin():
    conn = mysql.connect()
    cur = conn.cursor(pymysql.cursors.DictCursor)
    try:
        username_entered = request.json["email"]
        password_entered = request.json["password"]
        check = cur.execute(
            "Select * FROM bizusers WHERE email ='" + str(username_entered) + "';"
        )
        if check:
            r = cur.fetchall()
            for i in r:
                if check_password_hash(i["password"], password_entered):
                    token = jwt.encode(
                        {
                            "email": request.json["email"],
                            "id": i["id"],
                            "type": i["type"],
                            "comp_type": i["comp_type"],
                            "exp": datetime.datetime.utcnow()
                            + datetime.timedelta(minutes=43200),
                        },
                        app.config["SECRET_KEY"],
                    )
                    resp = jsonify(
                        {
                            "comp_type": i["comp_type"],
                            "token": token.decode("utf-8"),
                            "type": i["type"],
                        }
                    )
                    resp.status_code = 200
                    return resp
                else:
                    resp = jsonify({"message": False})
                    resp.status_code = 403
                    return resp
        return jsonify({"message": "No Bizuser Found."})
    finally:
        cur.close()
        conn.close()


@app.route("/change_passw_biz", methods=["POST"])
@check_for_token
def change_passw_biz():
    conn = mysql.connect()
    cur = conn.cursor(pymysql.cursors.DictCursor)
    password_entered = request.json["password"]
    n_password_entered = generate_password_hash(request.json["new_password"])
    token = request.headers["Authorization"]
    user = jwt.decode(token, app.config["ADMIN_SECRET_KEY"])
    try:
        check = cur.execute(
            "Select * FROM bizusers WHERE email ='"
            + str(user["email"])
            + "' AND id = '"
            + str(user["id"])
            + "';"
        )
        if check:
            records = cur.fetchall()
            for r in records:
                if check_password_hash(r["password"], password_entered):
                    cur.execute(
                        "UPDATE bizusers SET password = '"
                        + str(n_password_entered)
                        + "' WHERE email = '"
                        + str(user["email"])
                        + "';"
                    )
                    conn.commit()
                    resp = jsonify({"message": "success"})
                    resp.status_code = 200
                    return resp
                resp = jsonify({"message": "wrong old password."})
                resp.status_code = 403
                return resp
        resp = jsonify({"message": "No BizUser Found."})
        resp.status_code = 405
        return resp
    finally:
        cur.close()
        conn.close()


@app.route("/forgot_passw_biz", methods=["POST"])
def forgot_passw_biz():
    conn = mysql.connect()
    cur = conn.cursor(pymysql.cursors.DictCursor)
    username_entered = request.json["email"]
    try:
        check = cur.execute(
            "Select * FROM bizusers WHERE email ='" + str(username_entered) + "';"
        )
        if check:
            otp = id_generator()
            # mail
            cur.execute(
                "UPDATE bizusers SET code = '"
                + str(otp)
                + "', forgot_password = 1 WHERE email = '"
                + str(username_entered)
                + "';"
            )
            conn.commit()
            resp = jsonify(
                {"message": "success", "otp": otp}
            )  # edit response after mail added.
            resp.status_code = 200
            return resp
        resp = jsonify({"message": "User not found."})
        resp.status_code = 403
        return resp

    finally:
        cur.close()
        conn.close()


@app.route("/change_fpassw_biz", methods=["POST"])
def change_fpassw_biz():
    conn = mysql.connect()
    cur = conn.cursor(pymysql.cursors.DictCursor)
    username_entered = request.json["email"]
    otp = request.json["otp"]
    new_passw = request.json["new_passw"]
    try:
        check = cur.execute(
            "Select * FROM bizusers WHERE email ='"
            + str(username_entered)
            + "' AND code ='"
            + str(otp)
            + "';"
        )
        if check:

            cur.execute(
                "UPDATE bizusers SET code = '0',forgot_password = 0, password='"
                + str(generate_password_hash(new_passw))
                + "' WHERE email = '"
                + str(username_entered)
                + "';"
            )
            conn.commit()
            resp = jsonify({"message": "success"})
            resp.status_code = 200
            return resp
        resp = jsonify({"message": "User not found."})
        resp.status_code = 403
        return resp

    finally:
        cur.close()
        conn.close()


@app.route("/create_edit_branch", methods=["POST"])
@check_for_token
def create_branch():
    conn = mysql.connect()
    token = request.headers["Authorization"]
    user = jwt.decode(token, app.config["SECRET_KEY"])

    bname = request.form["bname"]
    pnum = request.form["pnum"]
    addr1 = request.form["addr1"]
    addr2 = request.form["addr2"]
    city = request.form["city"]
    postalcode = request.form["postalcode"]
    geolocation = request.form["geolocation"]
    province = request.form["province"]
    comp_id = user["id"]
    filename = "default.png"
    if request.files["company_logo"]:
        company_logo = request.files["company_logo"]
        filename = secure_filename(company_logo.filename)
        company_logo.save(os.path.join(app.config["UPLOAD_FOLDER"], filename))
    w_hrs = request.form["w_hrs"]
    print(filename)
    cur = conn.cursor(pymysql.cursors.DictCursor)
    try:
        if user["type"] == "company":
            cur.execute("Select * from bizusers WHERE id = '" + str(comp_id) + "'")
            check = cur.fetchall()
            if check:
                if request.form["req"] == "create":
                    print(user["comp_type"])

                    if user["comp_type"] == "booking":
                        services = request.form["services"]
                        timezone = request.form["timezone"]
                        notify_time = request.form["notify"]
                        bpd = request.form["booking_perday"]
                        bphrs = request.form["booking_perhrs"]
                        op = eqbiz.create_branch(
                            user["comp_type"],
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
                            0,
                            0,
                            0,
                        )  # threshold, department

                    elif user["comp_type"] == "multitoken":
                        threshold = request.form["threshold"]
                        department = request.form["department"]
                        op = eqbiz.create_branch(
                            user["comp_type"],
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
                            0,
                            0,
                            0,
                            0,
                            0,
                            filename,
                            threshold,
                            department,
                            0,
                        )

                    elif user["comp_type"] == "token":
                        threshold = request.form["threshold"]
                        department = request.form["department"]
                        counter = request.form["counter"]
                        op = eqbiz.create_branch(
                            user["comp_type"],
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
                            0,
                            0,
                            0,
                            0,
                            0,
                            filename,
                            threshold,
                            department,
                            counter,
                        )

                    else:
                        resp = jsonify({"message": "INVALID Company type."})
                        resp.status_code = 405
                        return resp

                    if op == 200:
                        resp = jsonify({"message": "successfully created."})
                        resp.status_code = 200
                        return resp
                    if op == 403:
                        resp = jsonify({"message": "error occured."})
                        resp.status_code = 403
                        return resp

                elif request.form["req"] == "update":
                    cur.execute(
                        "Select * from branch_details WHERE id = '"
                        + str(request.form["branchid"])
                        + "'"
                    )
                    check = cur.fetchone()
                    if check:
                        branchid = check["id"]
                        if request.files["company_logo"]:
                            company_logo = request.files["company_logo"]
                            filename = secure_filename(company_logo.filename)
                            company_logo.save(
                                os.path.join(app.config["UPLOAD_FOLDER"], filename)
                            )
                        else:
                            filename = check["profile_photo_url"]

                        if user["comp_type"] == "booking":
                            services = request.form["services"]
                            timezone = request.form["timezone"]
                            notify_time = request.form["notify"]
                            bpd = request.form["booking_perday"]
                            bphrs = request.form["booking_perhrs"]
                            op = eqbiz.edit_branch(
                                user["comp_type"],
                                branchid,
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
                                0,
                                0,
                                0,
                            )

                        elif user["comp_type"] == "multitoken":
                            threshold = request.form["threshold"]
                            department = request.form["department"]
                            op = eqbiz.edit_branch(
                                user["comp_type"],
                                branchid,
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
                                0,
                                0,
                                0,
                                0,
                                0,
                                filename,
                                threshold,
                                department,
                                0,
                            )

                        elif user["comp_type"] == "token":
                            threshold = request.form["threshold"]
                            department = request.form["department"]
                            counter = request.form["counter"]
                            op = eqbiz.edit_branch(
                                user["comp_type"],
                                branchid,
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
                                0,
                                0,
                                0,
                                0,
                                0,
                                filename,
                                threshold,
                                department,
                                counter,
                            )

                        else:
                            resp = jsonify({"message": "INVALID Company type."})
                            resp.status_code = 405
                            return resp

                        if op == 200:
                            resp = jsonify({"message": "successfully updated."})
                            resp.status_code = 200
                            return resp
                        if op == 403:
                            resp = jsonify({"message": "error occured."})
                            resp.status_code = 403
                            return resp

                    else:
                        resp = jsonify({"message": "INVALID BRANCH ID."})
                        resp.status_code = 405
                        return resp

                elif request.form["req"] == "delete":
                    cur.execute(
                        "Select * from branch_details WHERE id = '"
                        + str(request.form["branchid"])
                        + "'"
                    )
                    check = cur.fetchone()
                    if check:
                        branchid = check["id"]
                        op = eqbiz.delete_branch(
                            branchid,
                        )

                        if op == 200:
                            resp = jsonify({"message": "successfully deleted."})
                            resp.status_code = 200
                            return resp
                        if op == 403:
                            resp = jsonify({"message": "error occured."})
                            resp.status_code = 403
                            return resp

                    resp = jsonify({"message": "INVALID Branch id maybe deleted.."})
                    resp.status_code = 405
                    return resp

                else:
                    resp = jsonify(
                        {"message": "INVALID Request only update/create/delete"}
                    )
                    resp.status_code = 405
                    return resp

            else:
                resp = jsonify({"message": "INVALID USER maybe deleted.."})
                resp.status_code = 405
                return resp

        resp = jsonify({"message": "ONLY Company can access."})
        resp.status_code = 405
        return resp

    finally:
        cur.close()
        conn.close()


@app.route("/dept_services", methods=["POST"])
@check_for_token
def dept_services():
    conn = mysql.connect()
    token = request.headers["Authorization"]
    user = jwt.decode(token, app.config["SECRET_KEY"])
    branch_id = request.json["branch_id"]
    cur = conn.cursor(pymysql.cursors.DictCursor)
    try:
        if user["type"] == "company":
            r = cur.execute(
                "Select * from branch_details WHERE id = '" + str(branch_id) + "'"
            )

            if r is None:
                resp = jsonify({"message": "INVALID branch id or no details found"})
                resp.status_code = 405
                return resp

            else:
                if user["comp_type"] == "booking":
                    find = "services"
                else:
                    find = "department"

                cur.execute(
                    "Select "
                    + str(find)
                    + " from branch_details WHERE id = '"
                    + str(branch_id)
                    + "'"
                )
                records = cur.fetchone()
                if records:
                    if find == "department":
                        kk = json.loads(records["department"])
                        d = kk.get("department")
                        resp = jsonify({"departments": d})
                    else:
                        kk = json.loads(records["services"])
                        s = kk.get("services")
                        sd = kk.get("services_desc")
                        r = kk.get("rates")
                        resp = jsonify(
                            {"services": s, "services_desc": sd, "services_rates": r}
                        )
                    resp.status_code = 200
                    conn.commit()
                    return resp

                resp = jsonify({"message": "Error."})
                resp.status_code = 403
                return resp

        resp = jsonify({"message": "ONLY Company can access."})
        resp.status_code = 405
        return resp

    finally:
        cur.close()
        conn.close()


@app.route("/create_employee", methods=["POST"])
@check_for_token
def create_employee():
    conn = mysql.connect()
    token = request.headers["Authorization"]
    user = jwt.decode(token, app.config["SECRET_KEY"])
    passw = generate_password_hash(request.json["password"])
    email = request.json["email"]
    cur = conn.cursor(pymysql.cursors.DictCursor)
    try:
        if user["type"] == "company":
            cur.execute("Select * from bizusers WHERE email = '" + str(email) + "'")
            r = cur.fetchone()
            if r["email"]:
                resp = jsonify({"message": "Email id taken."})
                resp.status_code = 405
                return resp
            else:
                check = cur.execute(
                    "INSERT INTO bizusers (email,password,comp_type,status,type) VALUES ('"
                    + str(email)
                    + "','"
                    + str(passw)
                    + "','"
                    + str(user["comp_type"])
                    + "',1,'employee');"
                )
                if check:
                    resp = jsonify(
                        {"message": "Employee Account Created successfully."}
                    )
                    resp.status_code = 200
                    conn.commit()
                    return resp
                resp = jsonify({"message": "Error."})
                resp.status_code = 403
                return resp

        resp = jsonify({"message": "ONLY Company can access."})
        resp.status_code = 405
        return resp

    finally:
        cur.close()
        conn.close()


# USER APIs STARTS HERE


@app.route("/login_otp", methods=["POST"])
def login_otp():
    conn = mysql.connect()
    cur = conn.cursor(pymysql.cursors.DictCursor)
    try:
        check = cur.execute(
            "SELECT id FROM equeue_users WHERE ( number = '"
            + str(request.form["number"])
            + "');"
        )
        if check:
            otp = id_generator()
            cur.execute(
                "UPDATE equeue_users SET code ='"
                + str(otp)
                + "' WHERE number = '"
                + str(request.form["number"])
                + "';"
            )
            conn.commit()
            print(otp)
            # send sms

            resp = jsonify({"message": "success"})
            resp.status_code = 200
            return resp
        else:
            resp = jsonify({"message": "Error No user found."})
            resp.status_code = 403
            return resp
    finally:
        cur.close()
        conn.close()


@app.route("/login", methods=["POST"])
def login():
    conn = mysql.connect()
    cur = conn.cursor(pymysql.cursors.DictCursor)
    try:
        check = cur.execute(
            "SELECT id FROM equeue_users WHERE number = '"
            + str(request.form["number"])
            + "' AND code = '"
            + str(request.form["code"])
            + "';"
        )
        if check:
            r = cur.fetchone()
            if r:
                kk = r["id"]
                token = jwt.encode(
                    {
                        "number": request.form["number"],
                        "user_id": kk,
                        "exp": datetime.datetime.utcnow()
                        + datetime.timedelta(minutes=43200),
                    },
                    app.config["USER_SECRET_KEY"],
                )
                resp = jsonify({"message": "success", "token": token.decode("utf-8")})
                resp.status_code = 200
                return resp
            else:
                resp = jsonify({"message": "Error No user found."})
                resp.status_code = 403
                return resp
    finally:
        cur.close()
        conn.close()


@app.route("/register", methods=["POST"])
def login_register():
    conn = mysql.connect()
    cur = conn.cursor(pymysql.cursors.DictCursor)
    cur2 = conn.cursor(pymysql.cursors.DictCursor)
    try:

        filename = str(app.config["USER_UPLOAD_FOLDER"]) + "default.png"
        if request.files["profile_img"]:
            company_logo = request.files["profile_img"]
            filename = secure_filename(company_logo.filename)
            company_logo.save(os.path.join(app.config["UPLOAD_FOLDER"], filename))

        check = cur.execute(
            "SELECT * FROM equeue_users WHERE ( number = '"
            + str(request.form["number"])
            + "');"
        )

        if check:
            resp = jsonify({"message": "You already have an account."})
            resp.status_code = 403
            return resp
        check = cur.execute(
            "SELECT id,bonus,referral_count FROM user_details WHERE ( referral_code = '"
            + str(request.form["referral_code"])
            + "');"
        )

        if check:
            records = cur.fetchall()
            for r in records:
                bonus = int(r["bonus"])
                referral_count = int(r["referral_count"])
            cur2.execute(
                "UPDATE user_details SET bonus = "
                + str(bonus + 20)
                + ", referral_count = "
                + str(referral_count + 1)
                + " WHERE referral_code = '"
                + str(request.form["referral_code"])
                + "';"
            )

            cur.execute(
                "Insert into user_details(name,profile_url,address1,address2,postalcode,city,province,phone_number,money,bonus,referral_code) VALUES ('"
                + str(request.form["name"])
                + "','"
                + filename
                + "','"
                + str(request.form["address1"])
                + "','"
                + str(request.form["address2"])
                + "','"
                + str(request.form["postalcode"])
                + "','"
                + str(request.form["city"])
                + "','"
                + str(request.form["province"])
                + "','"
                + str(request.form["phonenumber"])
                + "',0,20"
                + ",'"
                + str(request.form["phonenumber"] + "@equeue")
                + "');"
            )
            phoneee = str(request.form["countrycode"]) + str(
                request.form["phonenumber"]
            )
            cur.execute(
                "Insert into equeue_users (number) VALUES ('" + str(phoneee) + "');"
            )
            conn.commit()
            if cur:
                token = jwt.encode(
                    {
                        "number": phoneee,
                        "user_id": cur.lastrowid,
                        "exp": datetime.datetime.utcnow()
                        + datetime.timedelta(minutes=43200),
                    },
                    app.config["SECRET_KEY"],
                )
                print(token.decode("utf-8"))
                resp = jsonify({"message": "success", "token": token.decode("utf-8")})
                resp.status_code = 200
                return resp
            resp = jsonify({"message": "Error."})
            resp.status_code = 403
            return resp

        else:
            cur.execute(
                "Insert into user_details(name,profile_url,address1,address2,postalcode,city,province,phone_number,money,bonus,referral_code) VALUES ('"
                + str(request.form["name"])
                + "','"
                + filename
                + "','"
                + str(request.form["address1"])
                + "','"
                + str(request.form["address2"])
                + "','"
                + str(request.form["postalcode"])
                + "','"
                + str(request.form["city"])
                + "','"
                + str(request.form["province"])
                + "','"
                + str(request.form["phonenumber"])
                + "',0,0"
                + ",'"
                + str(request.form["phonenumber"] + "@equeue")
                + "');"
            )
            phoneee = str(request.form["countrycode"]) + str(
                request.form["phonenumber"]
            )
            cur.execute(
                "Insert into equeue_users (number) VALUES ('" + str(phoneee) + "');"
            )

            conn.commit()
            if cur:
                token = jwt.encode(
                    {
                        "number": phoneee,
                        "user_id": cur.lastrowid,
                        "exp": datetime.datetime.utcnow()
                        + datetime.timedelta(minutes=43200),
                    },
                    app.config["SECRET_KEY"],
                )
                print(token.decode("utf-8"))
                resp = jsonify({"message": "success", "token": token.decode("utf-8")})
                resp.status_code = 200
                return resp
            resp = jsonify({"message": "Error."})
            resp.status_code = 403
            return resp
    finally:
        cur.close()
        conn.close()


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
