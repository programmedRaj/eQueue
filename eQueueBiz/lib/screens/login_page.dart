import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/providers/auth_prov.dart';
import 'package:equeuebiz/screens/forgot_password.dart';
import 'package:equeuebiz/screens/homepage.dart';
import 'package:equeuebiz/services/app_toast.dart';
import 'package:equeuebiz/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  String lang;

  @override
  void initState() {
    super.initState();
  }

  // executeLogin(String email, String password) async {
  //   try {
  //     var url = Uri.parse('http://127.0.0.1:5000/adminsign_in');
  //     http
  //         .post(url,
  //             headers: {'Content-Type': 'application/json'},
  //             body: jsonEncode({'email': email, 'password': password}))
  //         .then((value) {
  //       print(jsonDecode(value.body));
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProv>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    child: Image.asset(
                      'lib/assets/bizlogo.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Text(
                      'eQueue Biz',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 400),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: AppColor.mainBlue,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(color: Colors.black26, blurRadius: 5)
                              ]),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(child: _userNameTextField()),
                              Flexible(
                                child: SizedBox(
                                  height: 20,
                                ),
                              ),
                              Flexible(child: _passwordTextField()),
                              Flexible(
                                  child: SizedBox(
                                height: 20,
                              )),
                              Flexible(
                                child: InkWell(
                                  onTap: () async {
                                    bool success = await value.execLogin(
                                        emailControler.text,
                                        passwordControler.text);
                                    if (success) {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString(
                                          'email', emailControler.text);
                                      prefs.setString(
                                          'pass', passwordControler.text);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomePage(),
                                          ));
                                    } else {
                                      AppToast.showErr(
                                          LocaleKeys.Error_logging_.tr());
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    decoration: BoxDecoration(
                                        color: AppColor.darkBlue,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: value.isLoading
                                        ? Center(
                                            child: SizedBox(
                                              height: 20,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                          )
                                        : Text(
                                            LocaleKeys.LogIn.tr(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ForgotPassPage(),
                                      ));
                                },
                                child: Text(
                                  LocaleKeys.ForgetPassword.tr(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _userNameTextField() {
    return TextFormField(
      controller: emailControler,
      style: TextStyle(fontSize: 20.5, color: Colors.white),
      decoration: InputDecoration(
        //focusColor: Colors.green,
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.white,
          size: 25.5,
        ),
        contentPadding: EdgeInsets.only(left: 0, top: 15, bottom: 0),
        labelText: LocaleKeys.Enter_username.tr(),
        labelStyle: TextStyle(fontSize: 16, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            style: BorderStyle.none,
            color: Colors.green,
          ),
        ),
      ),
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      controller: passwordControler,
      obscureText: true,
      style: TextStyle(fontSize: 20.5, color: Colors.white),
      decoration: InputDecoration(
        //focusColor: Colors.green,
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),

        prefixIcon: Icon(
          Icons.star,
          color: Colors.white,
          size: 25.5,
        ),
        contentPadding: EdgeInsets.only(left: 0, top: 15, bottom: 0),
        labelText: LocaleKeys.Enter_username.tr(),
        labelStyle: TextStyle(fontSize: 16, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            style: BorderStyle.none,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
