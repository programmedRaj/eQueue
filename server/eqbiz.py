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
    acctype,
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
    counter,
):
    conn = mysql.connect()
    cur = conn.cursor(pymysql.cursors.DictCursor)
    cur2 = conn.cursor(pymysql.cursors.DictCursor)
    try:
        if acctype == "booking":
            q = (
                "INSERT INTO branch_details(bname,phone_number,address1,address2,city,postalcode,geolocation,province,comp_id,working_hours,services,timezone,notify_time,booking_per_day,per_day_hours,profile_photo_url,money_earned) VALUES ('"
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
        elif acctype == "token":
            q = (
                "INSERT INTO branch_details(bname,phone_number,address1,address2,city,postalcode,geolocation,province,comp_id,working_hours,department,threshold,profile_photo_url,counter_count,money_earned) VALUES ('"
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
                + "','"
                + str(counter)
                + "','0');"
            )
        elif acctype == "multitoken":
            q = (
                "INSERT INTO branch_details(bname,phone_number,address1,address2,city,postalcode,geolocation,province,comp_id,working_hours,department,threshold,profile_photo_url,money_earned) VALUES ('"
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
        conn.commit()
        if check:
            return 200
        return 403

    finally:
        cur.close()
        cur2.close()
        conn.close()


def edit_branch(
    acctype,
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
    threshold,
    department,
    counter,
):
    conn = mysql.connect()
    cur = conn.cursor(pymysql.cursors.DictCursor)

    try:
        print(acctype)
        if acctype == "booking":
            q = (
                "UPDATE branch_details SET bname = '"
                + str(bname)
                + "',profile_photo_url = '"
                + str(filename)
                + "',phone_number = '"
                + str(pnum)
                + "',address1='"
                + str(addr1)
                + "',address2='"
                + str(addr2)
                + "',city='"
                + str(city)
                + "',postalcode='"
                + str(postalcode)
                + "',geolocation='"
                + str(geolocation)
                + "',province='"
                + str(province)
                + "',comp_id='"
                + str(comp_id)
                + "',working_hours='"
                + str(w_hrs)
                + "',services='"
                + str(services)
                + "',timezone='"
                + str(timezone)
                + "',notify_time='"
                + str(notify_time)
                + "',booking_per_day='"
                + str(bpd)
                + "',per_day_hours='"
                + str(bphrs)
                + "' WHERE id ="
                + str(branchid)
                + ";"
            )
        elif acctype == "token":
            q = (
                "UPDATE branch_details SET bname = '"
                + str(bname)
                + "',profile_photo_url = '"
                + str(filename)
                + "',phone_number = '"
                + str(pnum)
                + "',address1='"
                + str(addr1)
                + "',address2='"
                + str(addr2)
                + "',city='"
                + str(city)
                + "',postalcode='"
                + str(postalcode)
                + "',geolocation='"
                + str(geolocation)
                + "',province='"
                + str(province)
                + "',comp_id='"
                + str(comp_id)
                + "',working_hours='"
                + str(w_hrs)
                + "',threshold='"
                + str(threshold)
                + "',department='"
                + str(department)
                + "',counter_count='"
                + str(counter)
                + "' WHERE id ="
                + str(branchid)
                + ";"
            )
        elif acctype == "multitoken":
            q = (
                "UPDATE branch_details SET bname = '"
                + str(bname)
                + "',profile_photo_url = '"
                + str(filename)
                + "',phone_number = '"
                + str(pnum)
                + "',address1='"
                + str(addr1)
                + "',address2='"
                + str(addr2)
                + "',city='"
                + str(city)
                + "',postalcode='"
                + str(postalcode)
                + "',geolocation='"
                + str(geolocation)
                + "',province='"
                + str(province)
                + "',comp_id='"
                + str(comp_id)
                + "',working_hours='"
                + str(w_hrs)
                + "',threshold='"
                + str(threshold)
                + "',department='"
                + str(department)
                + "' WHERE id ="
                + str(branchid)
                + ";"
            )

        fire = str(q)
        print(fire)
        cur2 = conn.cursor(pymysql.cursors.DictCursor)
        check = cur2.execute(fire)
        conn.commit()
        if check:
            return 200
        return 403

    finally:
        cur.close()
        cur2.close()
        conn.close()


def delete_branch(branchid):
    conn = mysql.connect()
    cur = conn.cursor(pymysql.cursors.DictCursor)
    try:

        check = cur.execute(
            "DELETE FROM branch_details WHERE id =" + str(branchid) + " ;"
        )
        conn.commit()
        if check:
            return 200
        return 403

    finally:
        cur.close()
        conn.close()


def create_employee(
    acctype,
    name,
    profile_url,
    branch_id,
    phone_number,
    services,
    counter_number,
    departments,
):
    conn = mysql.connect()
    cur = conn.cursor(pymysql.cursors.DictCursor)
    cur2 = conn.cursor(pymysql.cursors.DictCursor)
    try:
        if acctype == "booking":
            q = (
                "INSERT INTO employee_details(name,profile_url,branch_id,phone_number,services,ratings,rating_count) VALUES ('"
                + str(name)
                + "','"
                + str(profile_url)
                + "','"
                + str(branch_id)
                + "','"
                + str(phone_number)
                + "','"
                + str(services)
                + "',"
                + "5,1);"
            )
        elif acctype == "token":
            q = (
                "INSERT INTO employee_details(name,profile_url,branch_id,phone_number,departments,counter_number,ratings,rating_count) VALUES ('"
                + str(name)
                + "','"
                + str(profile_url)
                + "','"
                + str(branch_id)
                + "','"
                + str(phone_number)
                + "','"
                + str(departments)
                + "','"
                + str(counter_number)
                + "',"
                + "5,1);"
            )
        elif acctype == "multitoken":
            q = (
                "INSERT INTO employee_details(name,profile_url,branch_id,phone_number,departments,counter_number,ratings,rating_count) VALUES ('"
                + str(name)
                + "','"
                + str(profile_url)
                + "','"
                + str(branch_id)
                + "','"
                + str(phone_number)
                + "','"
                + str(departments)
                + "','"
                + str(counter_number)
                + "',"
                + "5,1);"
            )

        fire = str(q)
        print(fire)
        check = cur2.execute(fire)
        conn.commit()
        if check:
            return 200
        return 403

    finally:
        cur.close()
        cur2.close()
        conn.close()


def edit_employee(
    employee_id,
    acctype,
    name,
    profile_url,
    branch_id,
    phone_number,
    services,
    counter_number,
    departments,
):
    conn = mysql.connect()
    cur = conn.cursor(pymysql.cursors.DictCursor)

    try:
        if acctype == "booking":
            q = (
                "UPDATE employee_details SET name = '"
                + str(name)
                + "',profile_url = '"
                + str(profile_url)
                + "',phone_number = '"
                + str(phone_number)
                + "',branch_id='"
                + str(branch_id)
                + "',services='"
                + str(services)
                + "' WHERE id ="
                + str(employee_id)
                + ";"
            )
        elif acctype == "token":
            q = (
                "UPDATE employee_details SET name = '"
                + str(name)
                + "',profile_url = '"
                + str(profile_url)
                + "',phone_number = '"
                + str(phone_number)
                + "',branch_id='"
                + str(branch_id)
                + "',departments='"
                + str(departments)
                + "',counter_number='"
                + str(counter_number)
                + "' WHERE id ="
                + str(employee_id)
                + ";"
            )
        elif acctype == "multitoken":
            q = (
                "UPDATE employee_details SET name = '"
                + str(name)
                + "',profile_url = '"
                + str(profile_url)
                + "',phone_number = '"
                + str(phone_number)
                + "',branch_id='"
                + str(branch_id)
                + "',departments='"
                + str(departments)
                + "',counter_number='"
                + str(counter_number)
                + "' WHERE id ="
                + str(employee_id)
                + ";"
            )

        fire = str(q)
        print(fire)
        cur2 = conn.cursor(pymysql.cursors.DictCursor)
        check = cur2.execute(fire)
        conn.commit()
        if check:
            return 200
        return 403

    finally:
        cur.close()
        cur2.close()
        conn.close()


def delete_employee(employee_id):
    conn = mysql.connect()
    cur = conn.cursor(pymysql.cursors.DictCursor)
    try:

        check = cur.execute(
            "DELETE FROM branch_details WHERE id =" + str(employee_id) + " ;"
        )
        conn.commit()
        if check:
            return 200
        return 403

    finally:
        cur.close()
        conn.close()