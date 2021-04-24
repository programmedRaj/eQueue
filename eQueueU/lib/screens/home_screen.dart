import 'dart:convert';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:eQueue/components/color.dart';
import 'package:eQueue/main.dart';
import 'package:eQueue/screens/pages/home.dart';
import 'package:eQueue/screens/pages/mapss.dart';
import 'package:eQueue/screens/pages/notification_screen.dart';
import 'package:eQueue/screens/pages/settings/settings.dart';
import 'package:eQueue/screens/pages/walletpage/wallet_page.dart';
import 'package:eQueue/translations/locale_keys.g.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class MessagingExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messaging Example App',
      theme: ThemeData.dark(),
      routes: {
        // '/': (context) => Application(),
        // '/message': (context) => MessageView(),
      },
    );
  }
}

// Crude counter to make messages unique
int _messageCount = 0;

/// The API endpoint here accepts a raw FCM payload for demonstration purposes.
String constructFCMPayload(String token) {
  _messageCount++;
  return jsonEncode({
    'token': token,
    'data': {
      'via': 'FlutterFire Cloud Messaging!!!',
      'count': _messageCount.toString(),
    },
    'notification': {
      'title': 'Hello FlutterFire!',
      'body': 'This notification (#$_messageCount) was created via FCM!',
    },
  });
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex;
  int sizz;

  String _token;

  @override
  void initState() {
    currentIndex = 0;
    super.initState();

    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: 'launch_background',
              ),
            ));
      }
    });
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if (width <= 320.0) {
      setState(() {
        sizz = 1;
      });
    } else if (height <= 850) {
      setState(() {
        sizz = 2;
      });
    }
    return WillPopScope(
      onWillPop: onWillPopp,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => MapSample()));
          },
          child: Icon(
            Icons.add_location,
            color: myColor[100],
          ),
          backgroundColor: myColor[50],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BubbleBottomBar(
          hasNotch: true,
          fabLocation: BubbleBottomBarFabLocation.end,
          opacity: .2,
          currentIndex: currentIndex,
          onTap: changePage,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                  16)), //border radius doesn't work when the notch is enabled.
          elevation: 8,
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
                backgroundColor: myColor[250],
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: myColor[50],
                ),
                title: Text(LocaleKeys.home).tr()),
            BubbleBottomBarItem(
                backgroundColor: myColor[250],
                icon: Icon(
                  Icons.monetization_on,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.monetization_on,
                  color: myColor[50],
                ),
                title: Text(LocaleKeys.wallet).tr()),
            BubbleBottomBarItem(
                backgroundColor: myColor[250],
                icon: Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.notifications,
                  color: myColor[50],
                ),
                title: Text(LocaleKeys.message).tr()),
            BubbleBottomBarItem(
                backgroundColor: myColor[250],
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.settings,
                  color: myColor[50],
                ),
                title: Text(LocaleKeys.settings).tr())
          ],
        ),
        body: currentIndex == 0
            ? Home()
            : currentIndex == 1
                ? Wallet()
                : currentIndex == 2
                    ? NotificationScreen()
                    : currentIndex == 3
                        ? Settings()
                        : null,
      ),
    );
  }

  Future<bool> onWillPopp() async {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () {
                  SystemNavigator.pop();
                  return Future.value(false);
                },
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }
}
