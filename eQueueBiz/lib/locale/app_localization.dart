import 'package:equeuebiz/l10n/messages_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalization {
  static Future<AppLocalization> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  // list of locales
  String get heyWorld {
    return Intl.message(
      'Hey World',
      name: 'heyWorld',
      desc: 'Simpel word for greeting ',
    );
  }

  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: 'Simpel word for greeting ',
    );
  }

  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: 'Simpel word for greeting ',
    );
  }

  String get forgetpassword {
    return Intl.message(
      'Forget Password',
      name: 'forgetpassword',
      desc: 'Simpel word for greeting ',
    );
  }

  String get createaccount {
    return Intl.message(
      'Create Account',
      name: 'createaccount',
      desc: 'Simpel word for greeting ',
    );
  }

  String get pleaseEnterEmail {
    return Intl.message(
      'Please Enter Email',
      name: 'pleaseEnterEmail',
      desc: 'Simpel word for greeting ',
    );
  }

  String get enterpassword {
    return Intl.message(
      'Enter Password',
      name: 'enterpassword',
      desc: 'Simpel word for greeting ',
    );
  }

  String get rememberpassword {
    return Intl.message(
      'Remember Password',
      name: 'rememberpassword',
      desc: 'Simpel word for greeting ',
    );
  }

  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: 'Simpel word for greeting ',
    );
  }

  String get register {
    return Intl.message(
      ' Register',
      name: 'register',
      desc: 'Simpel word for greeting ',
    );
  }

  String get nickname {
    return Intl.message(
      'Nickname',
      name: 'nickname',
      desc: 'Simpel word for greeting ',
    );
  }

  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: 'Simpel word for greeting ',
    );
  }

  String get mobilenumber {
    return Intl.message(
      'Mobile Number',
      name: 'mobilenumber',
      desc: 'Simpel word for greeting ',
    );
  }

  String get alreadyacc {
    return Intl.message(
      'Already Have An Account?',
      name: 'alreadyacc',
      desc: 'Simpel word for greeting ',
    );
  }

  String get enternickname {
    return Intl.message(
      'Please Enter Nickname',
      name: 'enternickname',
      desc: 'Simpel word for greeting ',
    );
  }

  String get entername {
    return Intl.message(
      'Please Enter name',
      name: 'entername',
      desc: 'Simpel word for greeting ',
    );
  }

  String get entermob {
    return Intl.message(
      'Mobile Number Should be 10 digits',
      name: 'entermob',
      desc: 'Simpel word for greeting ',
    );
  }

  String get invalidemail {
    return Intl.message(
      'Invalid Email',
      name: 'invalidemail',
      desc: 'Simpel word for greeting ',
    );
  }

  String get createtoken {
    return Intl.message(
      'Create Token',
      name: 'createtoken',
      desc: 'Simpel word for greeting ',
    );
  }

  String get taptocreatenewtoken {
    return Intl.message(
      'Tap To Create New Token',
      name: 'taptocreatenewtoken',
      desc: 'Simpel word for greeting ',
    );
  }

  String get onwait {
    return Intl.message(
      'Onwait',
      name: 'onwait',
      desc: 'Simpel word for greeting ',
    );
  }

  String get onqueue {
    return Intl.message(
      'Onqueue',
      name: 'onqueue',
      desc: 'Simpel word for greeting ',
    );
  }

  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: 'Simpel word for greeting ',
    );
  }

  String get recall {
    return Intl.message(
      'Recall',
      name: 'recall',
      desc: 'Simpel word for greeting ',
    );
  }

  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: 'Simpel word for greeting ',
    );
  }

  String get taptomarkasread {
    return Intl.message(
      'Tap To Mark As Read',
      name: 'taptomarkasread',
      desc: 'Simpel word for greeting ',
    );
  }

  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: 'Simpel word for greeting ',
    );
  }

  String get generatetoken {
    return Intl.message(
      'Generate Token',
      name: 'generatetoken',
      desc: 'Simpel word for greeting ',
    );
  }

  String get historysearch {
    return Intl.message(
      'History Search',
      name: 'historysearch',
      desc: 'Simpel word for greeting ',
    );
  }

  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: 'Simpel word for greeting ',
    );
  }

  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: 'Simpel word for greeting ',
    );
  }

  String get termsconditions {
    return Intl.message(
      'Terms&Conditions',
      name: 'termsconditions',
      desc: 'Simpel word for greeting ',
    );
  }

  String get privacypolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacypolicy',
      desc: 'Simpel word for greeting ',
    );
  }

  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: 'Simpel word for greeting ',
    );
  }

  String get signout {
    return Intl.message(
      'Sign Out',
      name: 'signout',
      desc: 'Simpel word for greeting ',
    );
  }

  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: 'Simpel word for greeting ',
    );
  }

  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: 'Simpel word for greeting ',
    );
  }

  String get noresults {
    return Intl.message(
      'No Results Found',
      name: 'noresults',
      desc: 'Simpel word for greeting ',
    );
  }

  String get pleasewait {
    return Intl.message(
      'Please Wait',
      name: 'pleasewait',
      desc: 'Simpel word for greeting ',
    );
  }

  String get toenterqueue {
    return Intl.message(
      'To Enter The Queue, Click Here!!',
      name: 'toenterqueue',
      desc: 'Simpel word for greeting ',
    );
  }

  String get nocompany {
    return Intl.message(
      'No Company Found',
      name: 'nocompany',
      desc: 'Simpel word for greeting ',
    );
  }

  String get nobranch {
    return Intl.message(
      'No Branch Found',
      name: 'nobranch',
      desc: 'Simpel word for greeting ',
    );
  }

  String get notokens {
    return Intl.message(
      'No Token Generated',
      name: 'notokens',
      desc: 'Simpel word for greeting ',
    );
  }

  String get nohistory {
    return Intl.message(
      'No History Available',
      name: 'nohistory',
      desc: 'Simpel word for greeting ',
    );
  }

  String get pincode {
    return Intl.message(
      'Pincode',
      name: 'pincode',
      desc: 'Simpel word for greeting ',
    );
  }

  String get postalcode {
    return Intl.message(
      'Postal Code',
      name: 'postalcode',
      desc: 'Simpel word for greeting ',
    );
  }

  String get sunday {
    return Intl.message(
      'Sunday',
      name: 'sunday',
      desc: 'Simpel word for greeting ',
    );
  }

  String get monday {
    return Intl.message(
      'Monday',
      name: 'monday',
      desc: 'Simpel word for greeting ',
    );
  }

  String get tuesday {
    return Intl.message(
      'Tuesday',
      name: 'tuesday',
      desc: 'Simpel word for greeting ',
    );
  }

  String get wednesday {
    return Intl.message(
      'Wednesday',
      name: 'wednesday',
      desc: 'Simpel word for greeting ',
    );
  }

  String get thrusday {
    return Intl.message(
      'Thrusday',
      name: 'thrusday',
      desc: 'Simpel word for greeting ',
    );
  }

  String get friday {
    return Intl.message(
      'Friday',
      name: 'friday',
      desc: 'Simpel word for greeting ',
    );
  }

  String get saturday {
    return Intl.message(
      'Saturday',
      name: 'saturday',
      desc: 'Simpel word for greeting ',
    );
  }

  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: 'Simpel word for greeting ',
    );
  }

  String get alreadytoken {
    return Intl.message(
      'You Already Have Token Of This Branch',
      name: 'alreadytoken',
      desc: 'Simpel word for greeting ',
    );
  }

  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: 'Simpel word for greeting ',
    );
  }

  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: 'Simpel word for greeting ',
    );
  }

  String get selectdep {
    return Intl.message(
      'Select Department',
      name: 'selectdep',
      desc: 'Simpel word for greeting ',
    );
  }

  String get gotodash {
    return Intl.message(
      'Go To DashBoard',
      name: 'gotodash',
      desc: 'Simpel word for greeting ',
    );
  }

  String get choosedep {
    return Intl.message(
      'Please choose a department',
      name: 'choosedep',
      desc: 'Simpel word for greeting ',
    );
  }

  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: 'Simpel word for greeting ',
    );
  }

  String get expectedtime {
    return Intl.message(
      'Expected Time',
      name: 'expectedtime',
      desc: 'Simpel word for greeting ',
    );
  }

  String get queuenotstarted {
    return Intl.message(
      'Your Queue Has Not Been Started',
      name: 'queuenotstarted',
      desc: 'Simpel word for greeting ',
    );
  }

  String get queueupdated {
    return Intl.message(
      'Queue being updated',
      name: 'queueupdated',
      desc: 'Simpel word for greeting ',
    );
  }

  String get wearetry {
    return Intl.message(
      'we are trying to connect...',
      name: 'wearetry',
      desc: 'Simpel word for greeting ',
    );
  }

  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: 'Simpel word for greeting ',
    );
  }

  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: 'Simpel word for greeting ',
    );
  }

  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: 'Simpel word for greeting ',
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  final Locale overriddenLocale;

  const AppLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) =>
      ['en', 'es', 'ar', 'fr', 'fa'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) => AppLocalization.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
