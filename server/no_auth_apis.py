import smtplib, ssl
from email import encoders
from email.message import Message
from email.mime.audio import MIMEAudio
from email.mime.base import MIMEBase
from email.mime.image import MIMEImage
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText


def mail(r_email, otp):

    port = 587  # For SSL
    smtp_server = "mail.nobatdeh.com"
    sender_email = "support@nobatdeh.com"  # Enter your address
    receiver_email = r_email  # Enter receiver address
    password = "Bill1234"
    msg = MIMEMultipart()
    msg["Subject"] = "OTP for setting New Password."
    msg["From"] = sender_email
    msg["To"] = receiver_email
    msg["Cc"] = sender_email
    msg.attach(MIMEText("Your OTP is:- " + str(otp) + ""))

    context = ssl.create_default_context()
    with smtplib.SMTP(smtp_server, port) as server:
        server.starttls()
        server.ehlo()
        server.login(sender_email, password)
        kk = server.sendmail(sender_email, receiver_email, msg.as_string())
        return 200
