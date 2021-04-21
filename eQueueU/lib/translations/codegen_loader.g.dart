// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar_AR = {
  "History": "تاريخ",
  "Tokens": "الرموز",
  "NoBookings": "الحجوزات"
};
static const Map<String,dynamic> en_US = {
  "History": "History",
  "Tokens": "Tokens",
  "NoBookings": "Bookings"
};
static const Map<String,dynamic> es_ES = {
  "History": "Historia",
  "Tokens": "Tokens",
  "NoBookings": "Reservaciones"
};
static const Map<String,dynamic> fa_FA = {
  "History": "تاریخچه",
  "Tokens": "شمارها",
  "NoBookings": "رزروها"
};
static const Map<String,dynamic> fr_FR = {
  "History": "Histoire",
  "Tokens": "Jetons",
  "NoBookings": "Réservations"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar_AR": ar_AR, "en_US": en_US, "es_ES": es_ES, "fa_FA": fa_FA, "fr_FR": fr_FR};
}
