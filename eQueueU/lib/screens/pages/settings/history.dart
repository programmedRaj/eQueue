import 'package:eQueue/api/models/displaybooking.dart';
import 'package:eQueue/api/models/displaytoken.dart';
import 'package:eQueue/components/color.dart';
import 'package:eQueue/provider/token_bookings_dikhao.dart';
import 'package:eQueue/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<DisplayTokenBook>(context, listen: false).displayboth('tokens');
    Provider.of<DisplayTokenBook>(context, listen: false)
        .displayboth('bookings');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DisplayTokenBook>(
      builder: (context, value, child) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                title: Text(LocaleKeys.History).tr(),
                bottom: TabBar(
                  // onTap: (index) {
                  //  // Tab index when user select it, it start from zero
                  // },
                  tabs: [
                    Tab(
                      icon: Icon(Icons.attach_money),
                      child: Text(LocaleKeys.Token).tr(),
                    ),
                    Tab(
                      icon: Icon(Icons.book_online),
                      child: Text(LocaleKeys.Booking).tr(),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  Container(
                    child: gettoken(context, value.tokens),
                  ),
                  Container(
                    child: getbook(context, value.bookings),
                  ),
                ],
              )),
        );
      },
    );
  }

  getbook(context, List<DisplayBookings> tob) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: tob.length,
        itemBuilder: (context, i) {
          return Container(
            height: height * 0.15,
            width: width,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: myColor[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                ),
              ],
            ),
            child: ListTile(
              trailing: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.red,
              ),
              title: Text(
                tob[i].branchtable.split('_')[0],
                style:
                    TextStyle(color: myColor[250], fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${LocaleKeys.Createdon.tr()} : ${tob[i].createdon}'),
                  Text('${LocaleKeys.Booking.tr()} : ${tob[i].bookings}'),
                ],
              ),
            ),
          );
        });
  }

  gettoken(context, List<DisplayToken> tob) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: tob.length,
        itemBuilder: (context, i) {
          return Container(
            height: height * 0.15,
            width: width,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: myColor[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                tob[i].branchtable.split('_')[0],
                style:
                    TextStyle(color: myColor[250], fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${LocaleKeys.Createdon.tr()} : ${tob[i].createdon}'),
                  Text('${LocaleKeys.Booking.tr()} : ${tob[i].token}'),
                ],
              ),
            ),
          );
        });
  }
}
