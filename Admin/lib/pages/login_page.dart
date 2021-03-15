import 'package:equeue_admin/pages/home/home.dart';
import 'package:equeue_admin/constants/appcolor.dart';
import 'package:equeue_admin/providers/login_prov.dart';
import 'package:equeue_admin/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(body: Consumer<LoginProv>(
        builder: (context, value, child) {
          if (value.success) {
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ));
            });
          }
          if (value.isError) {
            AppToast.showErr("error logging");
          }
          return Container(
            alignment: Alignment.center,
            color: Colors.white,
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
                          onTap: () {
                            value.executeLogin(
                                emailControler.text, passwordControler.text);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                                color: AppColor.darkBlue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )),
    );
  }

  Widget _userNameTextField() {
    return TextFormField(
      controller: emailControler,
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 20.5),
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
        labelText: 'Enter username',
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
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 20.5),
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
        labelText: 'Enter password',
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
