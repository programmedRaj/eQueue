import 'package:shared_preferences/shared_preferences.dart';

class SP {
  storeEmail(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', value);
  }

  storePass(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('pass', value);
  }
}
