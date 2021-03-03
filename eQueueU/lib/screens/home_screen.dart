import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:eQueue/components/color.dart';
import 'package:eQueue/screens/pages/home.dart';
import 'package:eQueue/screens/pages/notification_screen.dart';
import 'package:eQueue/screens/pages/settings/settings.dart';
import 'package:eQueue/screens/pages/walletpage/wallet_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex;
  int sizz;
  @override
  void initState() {
    super.initState();
    currentIndex = 0;
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
              title: Text("Home")),
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
              title: Text("Wallet")),
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
              title: Text("Message")),
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
              title: Text("Settings"))
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
    );
  }
}
