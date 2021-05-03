import 'package:equeuebiz/providers/booking_userdets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDets extends StatefulWidget {
  final String bid;
  final String userid;
  final String token;
  UserDets({this.bid, this.userid, this.token});
  @override
  _UserDetsState createState() => _UserDetsState();
}

class _UserDetsState extends State<UserDets> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<BookingDetUserDets>(context, listen: false)
          .getbookdets(widget.bid, widget.userid, widget.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('User Details'),
          ),
          body: SingleChildScrollView(
              child: Container(
            child: Column(
              children: [Text('')],
            ),
          )),
        );
      },
    );
  }
}
