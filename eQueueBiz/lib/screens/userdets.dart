import 'package:equeuebiz/providers/booking_userdets.dart';
import 'package:equeuebiz/translations/locale_keys.g.dart';
import 'package:equeuebiz/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class UserDets extends StatefulWidget {
  final String? bid;
  final String? userid;
  final String? token;
  UserDets({this.bid, this.userid, this.token});
  @override
  _UserDetsState createState() => _UserDetsState();
}

class _UserDetsState extends State<UserDets> {
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<BookingDetUserDets>(context, listen: false)
        .getbookdets(widget.bid, widget.userid, widget.token);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<BookingDetUserDets>(
      builder: (context, value, child) {
        print(value.view.length.toString());
        return Scaffold(
          appBar: whiteAppBar(context, 'User Details') as PreferredSizeWidget?,
          body: SingleChildScrollView(
              child: value.view.length <= 0
                  ? Container(
                      alignment: Alignment.center,
                      child: Text(
                          '${LocaleKeys.NO.tr()} ${LocaleKeys.UserDetails.tr()}'),
                    )
                  : Container(
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.all(10),
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300]!,
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: height * 0.01),
                            child: Text(
                              '${LocaleKeys.Name.tr()} : ${value.view[0].name}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: height * 0.02),
                            child: Text(
                              '${LocaleKeys.Address_Line_1.tr()} : ${value.view[0].add1}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: height * 0.01),
                            child: Text(
                              '${LocaleKeys.Address_Line_2.tr()} : ${value.view[0].add2}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: height * 0.01),
                            child: Text(
                              '${LocaleKeys.City.tr()} : ${value.view[0].city}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: height * 0.01),
                            child: Text(
                              '${LocaleKeys.PhoneNo.tr()} : ${value.view[0].phone}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: height * 0.01),
                            child: Text(
                              '${LocaleKeys.State_Province.tr()} : ${value.view[0].province}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: height * 0.01),
                            child: Text(
                              '${LocaleKeys.Postal_Code.tr()} : ${value.view[0].postal} ',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
        );
      },
    );
  }
}
