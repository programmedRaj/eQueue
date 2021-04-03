import 'package:eQueue/api/models/register.dart';

abstract class BaseApi {
  Future<Register> register(
      {String email, String fname, String lname, String passw, String contact});
  // Future<Login> login(int logintype, String contact, String password);
}
