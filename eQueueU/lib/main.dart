import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:eQueue/check.dart';
import 'package:eQueue/provider/branch_provider.dart';
import 'package:eQueue/provider/check_slot.dart';
import 'package:eQueue/provider/company_provider.dart';
import 'package:eQueue/provider/delete_token_branch.dart';
import 'package:eQueue/provider/map_marker.dart';
import 'package:eQueue/provider/payment_provider.dart';
import 'package:eQueue/provider/paymentdone.dart';
import 'package:eQueue/provider/send_booking.dart';
import 'package:eQueue/provider/send_token.dart';
import 'package:eQueue/provider/token_bookings_dikhao.dart';
import 'package:eQueue/provider/token_check_provider.dart';
import 'package:eQueue/provider/transaction_provider.dart';
import 'package:eQueue/provider/user_details_provider.dart';
import 'package:eQueue/translations/codegen_loader.g.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'components/color.dart';
import 'provider/department_booking_provider.dart';
import 'provider/department_token_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    EasyLocalization(
      fallbackLocale: Locale('en', 'US'),
      assetLoader: CodegenLoader(),
      child: MyApp(),
      supportedLocales: [
        Locale('en', 'US'), //english
        Locale('es', 'ES'), // spanish
        Locale('ar', 'AR'), // Arabic
        Locale('fr', 'FR'), // french
        Locale('fa', 'FA'),
        Locale('hi', 'IN'),
      ],
      path: 'lib/assets/translations',
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // AndroidInitializationSettings androidInitializationSettings;
  // IOSInitializationSettings iosInitializationSettings;
  // InitializationSettings initializationSettings;
  // final AppLocalizationDelegate _localeOverrideDelegate =
  //     AppLocalizationDelegate(Locale('en', 'US'));

  // void initializing() async {
  //   androidInitializationSettings =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');
  //   initializationSettings =
  //       InitializationSettings(android: androidInitializationSettings);
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //       onSelectNotification: onSelectNotification);
  // }

  // Future<void> notification(message) async {
  //   AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //           'Channel ID', 'Channel title', 'channel body',
  //           priority: Priority.high,
  //           importance: Importance.max,
  //           ticker: 'test');

  //   NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(0, message['data']['title'],
  //       message['data']['message'], notificationDetails);
  // }

  // Future onSelectNotification(String payLoad) {
  //   if (payLoad != null) {
  //     print(payLoad);
  //   }

  //   // we can set navigator to navigate another screen
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: DeletetokenProvider()),
        ChangeNotifierProvider.value(value: CompanyProvider()),
        ChangeNotifierProvider.value(value: MapMarker()),
        ChangeNotifierProvider.value(value: PaymentDoneProvider()),
        ChangeNotifierProvider.value(value: BranchProvider()),
        ChangeNotifierProvider.value(value: DepProvider()),
        ChangeNotifierProvider.value(value: DepBookProvider()),
        ChangeNotifierProvider.value(value: TokenChecker()),
        ChangeNotifierProvider.value(value: SendToken()),
        ChangeNotifierProvider.value(value: SendBooking()),
        ChangeNotifierProvider.value(value: SlotProvider()),
        ChangeNotifierProvider.value(value: UserDetails()),
        ChangeNotifierProvider.value(value: PayProvider()),
        ChangeNotifierProvider.value(value: DisplayTokenBook()),
        ChangeNotifierProvider.value(value: TransactionProvider()),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'E-Queue',
        theme: ThemeData(
          iconTheme: IconThemeData(color: myColor[100]),
          primaryColor: myColor[100], //white
          accentColor: myColor[50], //primary blue
          highlightColor: myColor[200], //darkblue
          hintColor: myColor[300], //black
          disabledColor: myColor[400],
          errorColor: Colors.red,
        ),
        home: AnimatedSplashScreen(
          duration: 3000,
          splash: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  'lib/assets/login.png',
                  height: 180,
                  width: 180,
                ),
              ),
              Container(
                child: Text('eQueue',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 400,
              ),
              Container(
                child: Text('From Bido Media Inc.',
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
          splashIconSize: 800,
          nextScreen: Check(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.leftToRight,
          backgroundColor: myColor[150],
        ),
      ),
    );
  }
}
