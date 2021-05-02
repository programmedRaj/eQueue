import 'package:equeuebiz/check.dart';
import 'package:equeuebiz/providers/all_tokens.dart';
import 'package:equeuebiz/providers/auth_prov.dart';
import 'package:equeuebiz/providers/biz_details.dart';
import 'package:equeuebiz/providers/branches_data_prov.dart';
import 'package:equeuebiz/providers/dept_data_prov.dart';
import 'package:equeuebiz/providers/emp_branchdets.dart';
import 'package:equeuebiz/providers/emp_data_provider.dart';
import 'package:equeuebiz/providers/status_booking.dart';
import 'package:equeuebiz/providers/token_dep_prov.dart';
import 'package:equeuebiz/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'locale/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'providers/booking_prov.dart';
import 'providers/booking_userdets.dart';
import 'providers/status_token.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppLocalizationDelegate _localeOverrideDelegate =
      AppLocalizationDelegate(Locale('en', 'US'));

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: DeptTokenDataProv()),
        ChangeNotifierProvider.value(value: AllToken()),
        ChangeNotifierProvider.value(value: BookingDet()),
        ChangeNotifierProvider.value(value: BizUserDets()),
        ChangeNotifierProvider.value(value: SortCheck()),
        ChangeNotifierProvider.value(value: BookingDetUserDets()),
        ChangeNotifierProvider.value(value: TokenStatus()),
        ChangeNotifierProvider<AuthProv>(
          create: (context) => AuthProv(),
        ),
        ChangeNotifierProvider<BookingBranDet>(
          create: (context) => BookingBranDet(),
        ),
        ChangeNotifierProvider<BranchDataProv>(
          create: (context) => BranchDataProv(),
        ),
        ChangeNotifierProvider<DeptDataProv>(
          create: (context) => DeptDataProv(),
        ),
        ChangeNotifierProvider<EmpDataProv>(
          create: (_) => EmpDataProv(),
        )
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          _localeOverrideDelegate
        ],
        supportedLocales: [
          const Locale('en', 'US'), //english
          const Locale('es', 'ES'), // spanish
          const Locale('ar', 'AR'), // Arabic
          const Locale('fr', 'FR'), // french
          const Locale('fa', 'FA'), // farsi
        ],
        title: 'eQueue Biz',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Check(),
      ),
    );
  }
}
