import 'package:eQueue/api/models/servicesmodel.dart';
import 'package:eQueue/check.dart';
import 'package:eQueue/components/color.dart';
import 'package:eQueue/provider/department_booking_provider.dart';
import 'package:eQueue/screens/pages/book_appointment.dart';
import 'package:eQueue/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class SelectService extends StatefulWidget {
  final int id;
  final int bid;
  final String type;
  final String branchname;
  final String companyname;
  final String wk;
  final String book;
  final String perday;
  final String ins;
  final String compid;
  SelectService(
      {this.id,
      this.compid,
      this.ins,
      this.bid,
      this.type,
      this.wk,
      this.book,
      this.perday,
      this.branchname,
      this.companyname});
  @override
  _SelectServiceState createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
  String dropval;
  String service;
  String serdes;
  String serrate;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<DepBookProvider>(context, listen: false).getdep(
      bid: widget.bid,
      id: widget.id,
      type: widget.type,
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print('ins here ${widget.ins}');

    return Consumer<DepBookProvider>(
      builder: (context, value, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text(LocaleKeys.createbookings).tr(),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) => Check()));
                    },
                    icon: Icon(Icons.home))
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: width,
                    decoration: BoxDecoration(
                      color: myColor[100],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300],
                          blurRadius: 4,
                        )
                      ],
                    ),
                    margin: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: height * 0.02),
                          child: Text(
                            '${LocaleKeys.CompanyName.tr()} : ${widget.companyname}',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: Text(
                            '${LocaleKeys.BranchName.tr()}: ${widget.branchname}',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: Text(
                            '${LocaleKeys.BranchType.tr()} : ${widget.type}',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        serrate != null
                            ? Container(
                                margin: EdgeInsets.only(top: height * 0.01),
                                child: Text(
                                  '${LocaleKeys.ServiceRate.tr()} : $serrate',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Container(
                    width: width,
                    child: Column(
                      children: [
                        Container(
                          width: width,
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).accentColor,
                                  width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                items: value.departs.map((val) {
                                  return new DropdownMenuItem<Service>(
                                    value: Service(
                                        service: val.service,
                                        servicedescription:
                                            val.servicedescription,
                                        servicerates: val.servicerates),
                                    child: new Text('${val.service}'),
                                  );
                                }).toList(),
                                hint: dropval == null
                                    ? Container(
                                        width: width * 0.45,
                                        child: Text(
                                          LocaleKeys.ChooseService,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .highlightColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800),
                                        ).tr(),
                                      )
                                    : Text(
                                        dropval,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800),
                                      ),
                                onChanged: (Service newVal) {
                                  dropval = '${newVal.service} ';
                                  this.setState(() {
                                    service = newVal.service;
                                    serrate = newVal.servicerates;
                                    serdes = newVal.servicedescription;
                                  });
                                }),
                          ),
                        ),
                        Container(
                            height: height * 0.3,
                            width: width,
                            margin: EdgeInsets.all(15),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: myColor[100],
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 0.4,
                                )
                              ],
                            ),
                            child: ListView(
                              children: [
                                serdes != null
                                    ? Text(serdes)
                                    : Text(LocaleKeys.NoDescription).tr(),
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: height * 0.06,
              margin: EdgeInsets.all(15),
              width: width,
              decoration: BoxDecoration(
                  color: myColor[50], borderRadius: BorderRadius.circular(10)),
              child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => Calen(
                              compid: widget.compid,
                              branchid: widget.bid,
                              branchname: widget.branchname,
                              companyname: widget.companyname,
                              servicename: service,
                              servicedess: serdes,
                              servicerate: serrate,
                              book: widget.book,
                              perday: widget.perday,
                              wk: widget.wk,
                              ins: widget.ins,
                              type: widget.type,
                            )));
                  },
                  child: Text(
                    LocaleKeys.ScheduleTime,
                    style: TextStyle(color: myColor[100]),
                  ).tr()),
            ));
      },
    );
  }
}
