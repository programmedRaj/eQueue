import 'package:eQueue/api/models/companymodel.dart';
import 'package:eQueue/components/color.dart';
import 'package:eQueue/provider/company_provider.dart';
import 'package:eQueue/screens/pages/branch_screen.dart';
import 'package:eQueue/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class Company extends StatefulWidget {
  @override
  _CompanyState createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  int sizz;
  List<CompanyModel> companylist;
  String searchval = "";
  List<CompanyModel> companysearch = [];
  String noprod;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<CompanyProvider>(context, listen: false)
        .getCompanies(sort: false);
  }

  @override
  Widget build(BuildContext context) {
    // Future.microtask(() =>
    //     Provider.of<CompanyProvider>(context, listen: false).getCompanies());
    // final comp = Provider.of<CompanyProvider>(context).companies;
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

    onsearch(v, List<CompanyModel> company) {
      v = v.toString().toUpperCase();
      print(v);
      if (v != null) {
        companysearch.clear();
        for (int i = 0; i < company.length; i++) {
          if (company[i].name.toLowerCase().contains(v) ||
              company[i].name.toUpperCase().contains(v) ||
              company[i].name.contains(v) ||
              company[i].descr.toLowerCase().contains(v) ||
              company[i].descr.toUpperCase().contains(v) ||
              company[i].descr.contains(v)) {
            companysearch.add(CompanyModel(
              acname: company[i].acname,
              acnum: company[i].acnum,
              bankname: company[i].bankname,
              descr: company[i].descr,
              earnedtilldate: company[i].earnedtilldate,
              id: company[i].id,
              ifsc: company[i].ifsc,
              moneyearned: company[i].moneyearned,
              name: company[i].name,
              onliner: company[i].onliner,
              profileurl: company[i].profileurl,
              type: company[i].type,
            ));
          } else {
            setState(() {
              noprod = LocaleKeys.nocompanies.tr();
            });
          }
        }
      }
    }

    return Consumer<CompanyProvider>(
      builder: (context, value, child) {
        var comp = value.companies;
        return SafeArea(
          child: Scaffold(
              body: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: height * 0.07,
                      width: width / 1.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: myColor[150],
                      ),
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            onChanged: (val) {
                              onsearch(val, value.companies);

                              if (val.length == 0) {
                                companysearch.clear();
                              }
                            },
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: LocaleKeys.searchcompanies.tr(),
                                suffixIcon: Icon(Icons.search)),
                          )),
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Container(
                      child: IconButton(
                          onPressed: () {
                            sortAlert();
                          },
                          icon: Icon(
                            Icons.sort,
                            color: myColor[250],
                          )),
                    ),
                    Row(children: [
                      PopupMenuButton<int>(
                        icon: Icon(
                          Icons.info,
                          color: myColor[150],
                          size: 30,
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: Row(
                              children: [
                                Container(
                                  height: height * 0.03,
                                  width: width * 0.04,
                                  // decoration: BoxDecoration(
                                  //     color: Colors.orangeAccent,
                                  //     borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    'T',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Text(LocaleKeys.Token).tr(),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Row(
                              children: [
                                Container(
                                  height: height * 0.03,
                                  width: width * 0.04,
                                  // decoration: BoxDecoration(
                                  //     color: Colors.green,
                                  //     borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    'M',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Text(
                                  LocaleKeys.MultiToken,
                                ).tr(),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 3,
                            child: Row(
                              children: [
                                Container(
                                  height: height * 0.03,
                                  width: width * 0.04,
                                  // decoration: BoxDecoration(
                                  //     color: Colors.blue,
                                  //     borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    'B',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Text(LocaleKeys.Booking).tr(),
                              ],
                            ),
                          ),
                        ],
                      )
                    ]),
                  ],
                ),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    height: height * 0.9,
                    width: width,
                    child: ListView.builder(
                        itemCount:
                            companysearch.length > 0 || companysearch.isNotEmpty
                                ? companysearch.length
                                : comp.length,
                        itemBuilder: (context, i) {
                          return Container(
                            height: height * 0.3,
                            margin: EdgeInsets.all(5),
                            width: width,
                            decoration: BoxDecoration(
                                color: myColor[100],
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(color: Colors.grey)]),
                            child: Column(
                              children: [
                                Flexible(
                                  child: Container(
                                      height: height * 0.2,
                                      width: width,
                                      alignment: Alignment.topRight,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                'lib/assets/imagecomp.jpg',
                                              ),
                                              fit: BoxFit.fill)),
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: myColor[100],
                                          child: companysearch.length > 0 ||
                                                  companysearch.isNotEmpty
                                              ? Text(
                                                  '${companysearch[i].type[0].toUpperCase()}')
                                              : Text(
                                                  '${comp[i].type[0].toUpperCase()}'),
                                        ),
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: width * 0.4,
                                            child: companysearch.length > 0 ||
                                                    companysearch.isNotEmpty
                                                ? Text(
                                                    companysearch[i].name,
                                                    style: TextStyle(
                                                        color: myColor[50],
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                : Text(
                                                    comp[i].name,
                                                    style: TextStyle(
                                                        color: myColor[50],
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: IconButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              icon: Icon(
                                                                Icons.close,
                                                                color:
                                                                    myColor[50],
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height:
                                                                height * 0.6,
                                                            width: width,
                                                            child: companysearch
                                                                            .length >
                                                                        0 ||
                                                                    companysearch
                                                                        .isNotEmpty
                                                                ? Text(
                                                                    '${LocaleKeys.CompanyDescription.tr()} : ${companysearch[i].descr}')
                                                                : Text(
                                                                    '${LocaleKeys.CompanyDescription.tr()} : ${comp[i].descr}'),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(top: 10),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                LocaleKeys.ViewDetails,
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ).tr(),
                                            ),
                                          )
                                        ],
                                      )),
                                      Container(
                                        height: height * 0.05,
                                        width: width * 0.4,
                                        decoration: BoxDecoration(
                                            color: myColor[50],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          companysearch.length >
                                                                      0 ||
                                                                  companysearch
                                                                      .isNotEmpty
                                                              ? BranchScreen(
                                                                  id: companysearch[
                                                                          i]
                                                                      .id,
                                                                  comp_type:
                                                                      companysearch[
                                                                              i]
                                                                          .type,
                                                                  companyname:
                                                                      companysearch[
                                                                              i]
                                                                          .name,
                                                                )
                                                              : BranchScreen(
                                                                  id: comp[i]
                                                                      .id,
                                                                  comp_type:
                                                                      comp[i]
                                                                          .type,
                                                                  companyname:
                                                                      comp[i]
                                                                          .name,
                                                                )));
                                            },
                                            child: Text(
                                              LocaleKeys.ViewDetails,
                                              style: TextStyle(
                                                  color: myColor[100]),
                                            ).tr()),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          )),
        );
      },
    );
  }

  sortAlert() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return MyD();
      },
    );
  }
}

class MyD extends StatefulWidget {
  @override
  _MyDState createState() => _MyDState();
}

class _MyDState extends State<MyD> {
  var _picked = "Name";
  var _order = "ASC";
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return AlertDialog(
      content: Container(
        height: height * 0.45,
        width: width,
        child: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                child: Text(LocaleKeys.SortBy).tr()),
            RadioButtonGroup(
              orientation: GroupedButtonsOrientation.HORIZONTAL,
              margin: const EdgeInsets.only(left: 12.0),
              onSelected: (String selected) => setState(() {
                _picked = selected;
                print(selected);
              }),
              labels: <String>[
                "Name",
                "Type",
              ],
              picked: _picked,
              itemBuilder: (Radio rb, Text txt, int i) {
                return Column(
                  children: <Widget>[
                    Icon(Icons.public),
                    rb,
                    txt,
                  ],
                );
              },
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: Text(LocaleKeys.SortOrder).tr()),
            RadioButtonGroup(
              orientation: GroupedButtonsOrientation.HORIZONTAL,
              margin: const EdgeInsets.only(left: 12.0),
              onSelected: (String selected) => setState(() {
                _order = selected;
              }),
              labels: <String>[
                "ASC",
                "DESC",
              ],
              picked: _order,
              itemBuilder: (Radio rb, Text txt, int i) {
                return Column(
                  children: <Widget>[
                    Icon(Icons.public),
                    rb,
                    txt,
                  ],
                );
              },
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.06,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Provider.of<CompanyProvider>(context, listen: false)
                            .getCompanies(
                                sort: true,
                                ascdsc: _order,
                                sortby: _picked.toLowerCase(),
                                type: 'company')
                            .then((value) => Navigator.of(context).pop());
                      },
                      child: Text(LocaleKeys.Ok).tr()),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(LocaleKeys.Cancel).tr())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
