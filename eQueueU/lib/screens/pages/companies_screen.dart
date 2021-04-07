import 'package:eQueue/api/models/companymodel.dart';
import 'package:eQueue/components/color.dart';
import 'package:eQueue/provider/company_provider.dart';
import 'package:eQueue/screens/pages/branch_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Company extends StatefulWidget {
  @override
  _CompanyState createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  int sizz;
  List<CompanyModel> companylist;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<CompanyProvider>(context, listen: false).getCompanies();
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
    return Consumer<CompanyProvider>(
      builder: (context, value, child) {
        var comp = value.companies;
        return SafeArea(
          child: Scaffold(
              body: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  height: height * 0.07,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: myColor[150],
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Search Companies',
                          style: TextStyle(
                              color: myColor[250], fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.search,
                          color: myColor[250],
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    height: height * 0.9,
                    width: width,
                    child: ListView.builder(
                        itemCount: comp.length,
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
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: AssetImage(
                                              'lib/assets/imagecomp.jpg',
                                            ),
                                            fit: BoxFit.fill)),
                                    child: IconButton(
                                      icon: Icon(Icons.info),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: SingleChildScrollView(
                                                child: Container(
                                                  child: Text(
                                                      'Company Type : ${comp[i].type.toUpperCase()}'),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
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
                                            child: Text(
                                              comp[i].name,
                                              style: TextStyle(
                                                  color: myColor[50],
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
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
                                                            child: Text(
                                                                'Company Description : ${comp[i].descr}'),
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
                                                'View Details',
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
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
                                                          BranchScreen(
                                                            id: comp[i].id,
                                                            comp_type:
                                                                comp[i].type,
                                                          )));
                                            },
                                            child: Text(
                                              'View Branches',
                                              style: TextStyle(
                                                  color: myColor[100]),
                                            )),
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
}
