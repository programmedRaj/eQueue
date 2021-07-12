import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/constants/textstyle.dart';
import 'package:equeuebiz/model/bookinh_model.dart';
import 'package:equeuebiz/providers/auth_prov.dart';
import 'package:equeuebiz/providers/booking_prov.dart';
import 'package:equeuebiz/providers/status_booking.dart';
import 'package:equeuebiz/screens/userdets.dart';
import 'package:equeuebiz/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class Bookings extends StatefulWidget {
  final String branchid;
  final String branchname;
  final String token;
  Bookings({this.branchid, this.branchname, this.token});
  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  DateTime _selectedDate = DateTime.now();
  AuthProv authProv;
  String _chosen;
  String choose;
  @override
  void initState() {
    super.initState();
    Provider.of<BookingDet>(context, listen: false).getbookdets(
        widget.branchid.toString(),
        widget.branchname,
        DateTime.now().toString().substring(0, 10),
        widget.token.toString());
    setState(() {
      choose = DateTime.now().toString().substring(0, 10);
    });
    callapi();
  }

  callapi() {
    Provider.of<BookingDet>(context, listen: false).getbookdets(
        widget.branchid.toString(),
        widget.branchname,
        choose,
        widget.token.toString());
  }

  Stream productsStream() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 10));
      callapi();

      yield null;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.token);
    return StreamBuilder(
      stream: productsStream(),
      builder: (context, snapshot) {
        return Consumer<BookingDet>(
          builder: (context, value, child) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: Text(
                    LocaleKeys.Bookings,
                    style: TextStyle(color: Colors.black),
                  ).tr(),
                  actions: [_dateFilter()],
                ),
                body: value.bms.length < 0 || value.bms.isEmpty
                    ? Container(
                        child: Center(
                          child: Text(LocaleKeys.No_Booking_found_today).tr(),
                        ),
                      )
                    : ListView.builder(
                        itemCount: value.bms.length,
                        itemBuilder: (context, index) {
                          return _tokenCard(value.bms[index]);
                        },
                      ));
          },
        );
      },
    );
  }

  Widget _dateFilter() {
    return InkWell(
      onTap: () {
        showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 30)))
            .then((value) {
          if (value != null) {
            setState(() {
              _selectedDate = value;
              choose = value.toString().substring(0, 10);
            });
            var d = _selectedDate.toString().substring(0, 10);
            Provider.of<BookingDet>(context, listen: false).getbookdets(
                widget.branchid.toString(),
                widget.branchname,
                d.toString(), // 2021-04-26itna dena hai input sirffffff cool
                widget.token);
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.mainBlue),
            borderRadius: BorderRadius.circular(4)),
        alignment: Alignment.center,
        child: Row(
          children: [
            Text(
              "${_selectedDate.day} / ${_selectedDate.month}",
              style: TextStyle(color: Colors.black),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }

  Widget _tokenCard(BookingModel bd) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 3)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "${LocaleKeys.Booking_Number.tr()} : ${bd.id}",
                style: blackBoldFS16,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            bd.insurance == 'paid'
                ? Text(LocaleKeys.Paid_by_cash).tr()
                : Text("${LocaleKeys.Insurance.tr()} : ${bd.insurance}"),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColor.mainBlue)),
                  child: Text(
                    bd.slots,
                    style: TextStyle(
                        color: AppColor.mainBlue, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColor.mainBlue)),
                  child: Text(
                    bd.department,
                    style: TextStyle(
                        color: AppColor.mainBlue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Divider(),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: DropdownButton<String>(
                      focusColor: Colors.white,
                      value: bd.status != null ? bd.status : _chosen,
                      //elevation: 5,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      items: <String>[
                        'onqueue',
                        'call',
                        'completed',
                        'cancelled',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        LocaleKeys.Status,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ).tr(),
                      onChanged: (String value) {
                        setState(() {
                          _chosen = value;
                        });
                        Provider.of<SortCheck>(context, listen: false)
                            .getSortdets(
                          bid: widget.branchid.toString(),
                          bname: widget.branchname,
                          status: value,
                          bookingid: bd.id,
                          userid: bd.userid,
                          dep: bd.department.substring(0, 3),
                          dt: bd.devicetoken,
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => UserDets(
                                bid: bd.branchid,
                                userid: bd.userid,
                                token: widget.token,
                              )));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            LocaleKeys.View_More,
                            style: TextStyle(
                                color: AppColor.mainBlue,
                                fontWeight: FontWeight.bold),
                          ).tr(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColor.mainBlue,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
