from datetime import datetime as dt
from time import gmtime, strftime
import pytz
import calendar
import time
import datetime
import pymysql
import json
import math

UTC = pytz.utc
# IST = pytz.timezone("Asia/Tehran")
IST = pytz.timezone("America/New_York")


def findDay(date):
    born = dt.strptime(date, "%d %m %Y").weekday()
    return calendar.day_name[born]


db = pymysql.connect(
    host="localhost",
    # user="admin_nobatdeh",
    user="admin_root",
    password="RS$5%kJs@!!2",
    database="admin_equeue",
)
cursor = db.cursor()
print(cursor)


for i in range(0, 8760):
    datetime_ist = dt.now(IST)
    todaysdate = datetime_ist.strftime("%d %m %Y")
    todayzdate = datetime_ist.strftime("%d/%m/%Y")
    day = findDay(todaysdate)
    hour = datetime_ist.strftime("%H")
    mins = datetime_ist.strftime("%M")
    print(int(hour))

    if int(hour) == 24 or int(hour) == 0:
        cursor.execute(
            "UPDATE tokenshistory SET consider = 1, status = 'cancelled' WHERE consider =0;"
        )
        db.commit()

        cursor.execute("SELECT bname,id FROM branch_details WHERE services IS NULL;")
        bdetails = cursor.fetchall()
        print(int(len(bdetails)))
        for i in range(0, int(len(bdetails))):
            bt = str(bdetails[i][0]) + "_" + str(bdetails[i][1])
            cursor.execute("TRUNCATE " + str(bt) + " ;")
            db.commit()
        time.sleep(3570)

    else:
        time.sleep(3600)
