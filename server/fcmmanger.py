import firebase_admin
from firebase_admin import credentials, messaging
from app import app


cred = credentials.Certificate(
    app.config["JSON_UPLOAD_FOLDER"] + "serviceAccountKey.json"
)
firebase_admin.initialize_app(cred)


def sendPush(title, msg, registration_token, dataObject=None):
    # See documentation on defining a message payload.
    message = messaging.MulticastMessage(
        notification=messaging.Notification(title=title, body=msg),
        data=dataObject,
        tokens=registration_token,
    )

    # Send a message to the device corresponding to the provided
    # registration token.
    response = messaging.send_multicast(message)
    # Response is a message ID string.
    if response:
        return 200
    else:
        return 403
