import 'package:eQueue/components/color.dart';
import 'package:eQueue/provider/user_details_provider.dart';
import 'package:eQueue/screens/pages/transactionpage.dart';
import 'package:eQueue/screens/pages/walletpage/add_money.dart';
import 'package:eQueue/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:easy_localization/easy_localization.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<UserDetails>(context, listen: false).getUserDet();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('hi');
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<UserDetails>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            leading: Container(),
            title: Text(LocaleKeys.yourwallet).tr(),
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  height: height * 0.4,
                  decoration: BoxDecoration(
                    color: myColor[100],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 0.6,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LocaleKeys.MyBalance,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ).tr(),
                            value.users.length == 0 || value.users == null
                                ? Text(
                                    LocaleKeys.loading,
                                  ).tr()
                                : Text(
                                    '\$${value.users[0].money}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 0.8,
                      ),
                      Container(
                        width: width / 1.4,
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: myColor[250],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: SwipeTo(
                                child: Container(
                                  height: height * 0.1,
                                  width: width * 0.3,
                                  margin: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: myColor[150],
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 0.6,
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.arrow_back_ios),
                                      Icon(Icons.arrow_forward_ios)
                                    ],
                                  )),
                                ),
                                iconOnLeftSwipe: Icons.arrow_forward,
                                leftSwipeWidget: CircleAvatar(
                                  radius: 20,
                                ),
                                iconOnRightSwipe: Icons.arrow_back,
                                rightSwipeWidget: CircleAvatar(
                                  radius: 20,
                                ),
                                onRightSwipe: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => ExistingCardsPage()));
                                },
                                onLeftSwipe: () {},
                              ),
                            ),
                            Container(
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: myColor[100],
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 30,
                                    color: myColor[50],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Center(
                            child: Text(
                          LocaleKeys.swiperighttoadd,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ).tr()),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => TransactionDets()));
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    //height: height * 0.07,
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(10),
                        color: myColor[100],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                          )
                        ]),
                    child: ListTile(
                      title: Text(LocaleKeys.mytransactions).tr(),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
