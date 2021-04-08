import 'package:equeue_admin/models/company_full_details.dart';
import 'package:equeue_admin/pages/add_company_page.dart';
import 'package:equeue_admin/pages/comp_more_opts.dart';
import 'package:equeue_admin/providers/comp_more_opts_prov.dart';
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
        print(value);
        return Container(
          child: value.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black, //data fetch nhi ho raha
                  ),
                )
              : value.isError
                  ? Center(
                      child: Column(
                        children: [
                          Text(
                            "Something went wrong",
                            style: TextStyle(color: Colors.black),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddCompanyPage(),
                                    )).then((val) {
                                  value.getCompanyDets();
                                });
                              },
                              child: Text(
                                'Add Company',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                          ),
                        ],
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
                                    )).then((val) {
                                  value.getCompanyDets();
                                });
                              },
                              child: Text(
                                'Add Company',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: PaginatedDataTable(
                              header: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Companies'),
                                  /* Row(
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
                                  ), */
                                ],
                              ),
                              columns: [
                                DataColumn(label: Text('Sr No.')),
                                DataColumn(label: Text('Name')),
                                DataColumn(label: Text('Email')),
                                DataColumn(label: Text('Status')),
                                DataColumn(label: Text("Actions"))
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

  Widget actionsRow(CompanyDets companyDets, CompEmailStatus compEmailStatus) {
    return Row(
      children: [
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCompanyPage(
                      compEmailStatus: compEmailStatus,
                      companyDets: companyDets,
                    ),
                  )).then((value) {
                Provider.of<CompFullDetsProv>(context, listen: false)
                    .getCompanyDets();
              });
            },
            child: Icon(
              Icons.edit,
              color: Colors.black,
            )),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () async {
            bool success =
                await Provider.of<CompMoreOptsProv>(context, listen: false)
                    .disableCompany(companyDets, compEmailStatus);
            if (success) {
              Provider.of<CompFullDetsProv>(context, listen: false)
                  .getCompanyDets();
            }
          },
          child: Icon(
            compEmailStatus.status == 1
                ? Icons.play_disabled
                : Icons.play_arrow,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () async {
            bool success =
                await Provider.of<CompMoreOptsProv>(context, listen: false)
                    .deleteCompany(companyDets, compEmailStatus);
            if (success) {
              Provider.of<CompFullDetsProv>(context, listen: false)
                  .getCompanyDets();
            }
          },
          child: Icon(
            Icons.delete,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  @override
  DataRow getRow(int index) {
    return DataRow(
        /*  onSelectChanged: (val) {
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
        }, */
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
          DataCell(Container(
              width: size == 1 ? width * 0.15 : width * 0.1,
              child: actionsRow(companyFullDetails.companyDetsList[index],
                  companyFullDetails.compEmailStatusList[index]))),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => companyFullDetails.compEmailStatusList.length;

  @override
  int get selectedRowCount => 0;
}
