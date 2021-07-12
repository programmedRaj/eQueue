import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/constants/textstyle.dart';
import 'package:equeuebiz/model/all_tokens.dart';
import 'package:equeuebiz/providers/all_tokens.dart';
import 'package:equeuebiz/providers/auth_prov.dart';
import 'package:equeuebiz/providers/dept_data_prov.dart';
import 'package:equeuebiz/providers/status_token.dart';
import 'package:equeuebiz/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class Tokens extends StatefulWidget {
  final int bid;
  final String token;
  final String bname;
  Tokens({this.bid, this.token, this.bname});
  @override
  _TokensState createState() => _TokensState();
}

class _TokensState extends State<Tokens> {
  List<String> tokenStatusList = [
    'onqueue',
    'ongoing',
    'completed',
    'cancelled',
  ];
  String _chosen;
  AuthProv authProv;
  String selectedDept;
  List<TokenAll> tok = [];

  @override
  void initState() {
    super.initState();
    callapi();
  }

  callapi() {
    Provider.of<DeptDataProv>(context, listen: false)
        .getDepts(widget.token, widget.bid);
    Provider.of<AllToken>(context, listen: false)
        .getTokendets(widget.bid.toString(), widget.bname, widget.token);
  }

  Stream tokenStream() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 10));
      callapi();

      yield null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: tokenStream(),
      builder: (context, snapshot) {
        return Consumer<DeptDataProv>(
          builder: (context, value, child) {
            return Consumer<AllToken>(
              builder: (context, value1, child) {
                if (selectedDept != null) {
                  tok = value1.tok
                      .where((element) => element.department == selectedDept)
                      .toList();
                }
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
                        LocaleKeys.Tokens,
                        style: TextStyle(color: Colors.black),
                      ).tr(),
                      actions: [_departmentFilter(value.deptsList)],
                    ),
                    body: value1.toks.length < 0 || value1.toks.isEmpty
                        ? Container(
                            child: Center(
                              child: Text(
                                  '${LocaleKeys.NO.tr()} ${LocaleKeys.Tokens.tr()}'),
                            ),
                          )
                        : ListView.builder(
                            itemCount: selectedDept == null
                                ? value1.toks.length
                                : tok.length,
                            itemBuilder: (context, index) {
                              return selectedDept == null
                                  ? _tokenCard(value1.toks[index])
                                  : _tokenCard(tok[index]);
                            },
                          ));
              },
            );
          },
        );
      },
    );
  }

  Widget _departmentFilter(depList) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.mainBlue),
          borderRadius: BorderRadius.circular(4)),
      child: DropdownButton<String>(
        underline: SizedBox(),
        isExpanded: false,
        focusColor: Colors.white,
        value: selectedDept,
        //elevation: 5,
        style: TextStyle(color: Colors.white),
        iconEnabledColor: Colors.black,
        items: depList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        hint: Text(
          "Select",
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        onChanged: (String value) {
          setState(() {
            selectedDept = value;
          });
        },
      ),
    );
  }

  Widget _tokenCard(TokenAll tokenL) {
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
                "${tokenL.department}-${tokenL.id}",
                style: blackBoldFS16,
              ),
            ),
            Center(
              child: Text(
                "${LocaleKeys.Status.tr()} : ${tokenL.status}",
                style: blackBoldFS16,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //Text("Token desc  s SD<C S<JD JC S<JDBC<JSB<JC "),
            Divider(),

            Container(
              child: DropdownButton<String>(
                focusColor: Colors.white,
                value: tokenL.status != null ? tokenL.status : _chosen,
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
                      value, //idrrrrrr
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                hint: Text(
                  LocaleKeys.Status.tr(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                onChanged: (String value) {
                  setState(() {
                    _chosen = value;
                  });
                  Provider.of<TokenStatus>(context, listen: false)
                      .getTokenstatusdets(
                    bid: widget.bid.toString(),
                    bname: widget.bname,
                    status: value,
                    bookingid: tokenL.id,
                    userid: tokenL.userid,
                    dep: tokenL.department.substring(0, 3),
                    dt: tokenL.devicetoken,
                  )
                      .then((v) {
                    Provider.of<DeptDataProv>(context, listen: false)
                        .getDepts(widget.token, widget.bid);
                    Provider.of<AllToken>(context, listen: false).getTokendets(
                        widget.bid.toString(), widget.bname, widget.token);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  OptionsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            dialogOptElement("on Wait"),
            Divider(
              thickness: 1,
              color: Colors.black.withOpacity(0.2),
            ),
            dialogOptElement("call"),
            Divider(
              thickness: 1,
              color: Colors.black.withOpacity(0.2),
            ),
            dialogOptElement("cancel")
          ],
        ),
      ),
    );
  }

  Widget dialogOptElement(String text) {
    return InkWell(
      onTap: () {
        setState(() {
          _chosen = text;
        });
        Navigator.pop(context);
      },
      child: Text(text),
    );
  }
}
