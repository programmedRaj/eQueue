import 'package:equeue_admin/models/company_full_details.dart';
import 'package:equeue_admin/pages/add_company_page.dart';
import 'package:equeue_admin/pages/comp_more_opts.dart';
import 'package:equeue_admin/providers/company_full_dets_prov.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Company extends StatefulWidget {
  @override
  _CompanyState createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  int _rowperpage = PaginatedDataTable.defaultRowsPerPage;
  List searchlist = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<CompFullDetsProv>(context, listen: false).getCompanyDets();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    /* var dts = searchlist == null || searchlist.isEmpty
        ? Dts(width, height, context , )
        : Dts(width, height, context); */
    return Consumer<CompFullDetsProv>(
      builder: (context, value, child) {
        return Container(
          child: value.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : value.isError
                  ? Center(
                      child: Text(
                        "Something went wrong",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddCompanyPage(),
                                    ));
                              },
                              child: Text(
                                'Add Company',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                          ),
                          // users == null || users.length == 0
                          //     ? Container(
                          //         child: Center(
                          //           child: Text('No Users Add Users'),
                          //         ),
                          //       )
                          //     :
                          PaginatedDataTable(
                            header: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Companies'),
                                Row(
                                  children: [
                                    Container(
                                        width: width * 0.2,
                                        child: TextField(
                                          onChanged: (value) {
                                            // setState(() {
                                            //   textdata = value;
                                            // });
                                            // onsearch(textdata);
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'Search'),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            columns: [
                              DataColumn(label: Text('Sr No.')),
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Email')),
                              DataColumn(label: Text('Status')),
                            ],
                            source: Dts(width, height, context,
                                value.companyFullDetails),
                            onRowsPerPageChanged: (val) {
                              setState(() {
                                _rowperpage = val;
                              });
                            },
                            rowsPerPage: _rowperpage,
                          ),
                        ],
                      ),
                    ),
        );
      },
    );
  }
}

class Dts extends DataTableSource {
  double width;
  double height;
  int size;
  List srno;
  BuildContext context;
  CompanyFullDetails companyFullDetails;
  Dts(this.width, this.height, this.context, this.companyFullDetails);
  String password;
  String password2;
  String error;
  final passwordkey = GlobalKey<FormState>();
  // final keys = Keyy();
  @override
  DataRow getRow(int index) {
    return DataRow(
        onSelectChanged: (val) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CompMoreOpts(
                    companyDets: companyFullDetails.companyDetsList[index],
                    compEmailStatus:
                        companyFullDetails.compEmailStatusList[index]),
              )).then((value) {
            Provider.of<CompFullDetsProv>(context, listen: false)
                .getCompanyDets();
          });
        },
        cells: [
          DataCell(Container(width: width * 0.1, child: Text("$index"))),
          DataCell(Container(
              width: width * 0.1,
              child: Text(companyFullDetails.companyDetsList[index].name))),
          DataCell(Container(
              width: size == 1 ? width * 0.15 : width * 0.2,
              child:
                  Text(companyFullDetails.compEmailStatusList[index].email))),
          DataCell(Container(
              width: size == 1 ? width * 0.15 : width * 0.1,
              child: Text(companyFullDetails.compEmailStatusList[index].status
                  .toString()))),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => companyFullDetails.compEmailStatusList.length;

  @override
  int get selectedRowCount => 0;
}
