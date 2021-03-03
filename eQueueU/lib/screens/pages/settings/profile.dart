import 'package:eQueue/components/color.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Container(
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: myColor[50],
                  ),
                ),
                Container(
                  child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Edit Photo',
                        style: TextStyle(
                          color: myColor[50],
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Form(
                child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    validator: (name) {
                      if (name.isEmpty)
                        return 'Please Enter Name';
                      else
                        return null;
                    },
                    initialValue: 'Rushabh',
                    decoration: InputDecoration(
                      hintText: 'Name',
                      prefixIcon: Icon(
                        Icons.person,
                        color: myColor[250],
                      ),
                      errorStyle: TextStyle(fontWeight: FontWeight.bold),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).errorColor, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: myColor[50], width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: myColor[250], width: 2.0),
                      ),
                    ),
                    onChanged: (v) {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (name) {
                      if (name.isEmpty)
                        return 'Please Enter Email';
                      else
                        return null;
                    },
                    initialValue: 'Rushabh Mehta',
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(
                        Icons.email,
                        color: myColor[250],
                      ),
                      errorStyle: TextStyle(fontWeight: FontWeight.bold),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).errorColor, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: myColor[50], width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: myColor[250], width: 2.0),
                      ),
                    ),
                    onChanged: (v) {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    validator: (name) {
                      if (name.isEmpty)
                        return 'Please Enter Email';
                      else
                        return null;
                    },
                    initialValue: '9930847178',
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: myColor[250],
                      ),
                      errorStyle: TextStyle(fontWeight: FontWeight.bold),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).errorColor, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: myColor[50], width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: myColor[250], width: 2.0),
                      ),
                    ),
                    onChanged: (v) {},
                  ),
                ),
                Container(
                  height: height * 0.06,
                  margin: EdgeInsets.all(15),
                  width: width,
                  decoration: BoxDecoration(
                      color: myColor[50],
                      borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Generate Token',
                        style: TextStyle(color: myColor[100]),
                      )),
                )
              ],
            )),
          )
        ],
      ),
    );
  }
}
