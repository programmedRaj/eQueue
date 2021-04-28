# -*- coding: utf-8 -*-
"""
Created on Tue Jun 23 17:44:47 2020

@author: user
"""

import os
from flask import Flask

app = Flask(__name__)

UPLOAD_FOLDER = os.getcwd() + "/uploads"
# UPLOAD_FOLDER = "./admin/domains/equeue.com/public_html/uploads"
app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER
BIZ_UPLOAD_FOLDER = os.getcwd() + "/uploads/biz-logos"
# BIZ_UPLOAD_FOLDER = "./admin/domains/equeue.com/public_html/uploads/biz-logos"
app.config["BIZ_UPLOAD_FOLDER"] = BIZ_UPLOAD_FOLDER
USER_UPLOAD_FOLDER = os.getcwd() + "/uploads/usersprofile/"
# USER_UPLOAD_FOLDER = "./admin/domains/equeue.com/public_html/uploads/usersprofile/"
app.config["USER_UPLOAD_FOLDER"] = USER_UPLOAD_FOLDER
app.config["MAX_CONTENT_LENGTH"] = 16 * 1024 * 1024
app.config["SECRET_KEY"] = "eQueue2021keyFREEloc"
app.config["ADMIN_SECRET_KEY"] = "eQueueADMIN2021keyFREEloc"
app.config["USER_SECRET_KEY"] = "eQueueUSERS2021keyFREEloc"

JSON_UPLOAD_FOLDER = os.getcwd() + "/jsons/"
app.config["JSON_UPLOAD_FOLDER"] = JSON_UPLOAD_FOLDER

# /var/www/html/rew
# /home/admin/domains/nobatdeh.com/public_html
# /home/admin/domains/equeue.com/public_html


# NEW API SMS ROUTE
# https://sms.bewin.one/sms/services/send.php?key=2d4f10360b952be6f4b460c03ae68b77f5279741&number=%2B14164000119&message=reeee&devices=3|0
