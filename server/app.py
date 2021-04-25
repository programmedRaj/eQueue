# -*- coding: utf-8 -*-
"""
Created on Tue Jun 23 17:44:47 2020

@author: user
"""

import os
from flask import Flask

app = Flask(__name__)

UPLOAD_FOLDER = os.getcwd() + "\\uploads"
app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER
BIZ_UPLOAD_FOLDER = os.getcwd() + "\\uploads\\biz-logos"
app.config["BIZ_UPLOAD_FOLDER"] = BIZ_UPLOAD_FOLDER
USER_UPLOAD_FOLDER = os.getcwd() + "\\uploads\\usersprofile\\"
app.config["USER_UPLOAD_FOLDER"] = USER_UPLOAD_FOLDER
app.config["MAX_CONTENT_LENGTH"] = 16 * 1024 * 1024
app.config["SECRET_KEY"] = "eQueue2021keyFREEloc"
app.config["ADMIN_SECRET_KEY"] = "eQueueADMIN2021keyFREEloc"
app.config["USER_SECRET_KEY"] = "eQueueUSERS2021keyFREEloc"

JSON_UPLOAD_FOLDER = os.getcwd() + "\\jsons\\"
app.config["JSON_UPLOAD_FOLDER"] = JSON_UPLOAD_FOLDER
