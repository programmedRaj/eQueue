import 'package:equeue_admin/models/branches_full_dets.dart';
import 'package:equeue_admin/models/company_full_details.dart';
import 'package:equeue_admin/pages/add_company_page.dart';
import 'package:equeue_admin/pages/comp_more_opts.dart';
import 'package:equeue_admin/pages/home/desktopview/employee.dart';
import 'package:equeue_admin/pages/login_page.dart';
import 'package:equeue_admin/providers/branch_prov.dart';
import 'package:equeue_admin/providers/comp_more_opts_prov.dart';
import 'package:equeue_admin/providers/company_full_dets_prov.dart';
import 'package:equeue_admin/providers/login_prov.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Branches extends StatefulWidget {
  final int? compId;
  Branches({required this.compId});
  @override
  _BranchesState createState() => _BranchesState();
}

class _BranchesState extends State<Branches> {
  int? _rowperpage = PaginatedDataTable.defaultRowsPerPage;
  List searchlist = [];
  LoginProv? loginProv;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<BranchDetsProv>(context, listen: false)
        .getBranches(widget.compId);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    loginProv = Provider.of<LoginProv>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Branches"),
      ),
      body: Consumer<BranchDetsProv>(
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
                              value.isEmpty
                                  ? "No branches"
                                  : "Something went wrong",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: PaginatedDataTable(
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Branches'),
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
                                  DataColumn(label: Text('Money Earned')),
                                  DataColumn(label: Text('Contact')),
                                  //DataColumn(label: Text("Actions"))
                                ],
                                source: Dts(width, height, context,
                                    value.branchFullDetails, loginProv),
                                onRowsPerPageChanged: (val) {
                                  setState(() {
                                    _rowperpage = val;
                                  });
                                },
                                rowsPerPage: _rowperpage!,
                              ),
                            ),
                          ],
                        ),
                      ),
          );
        },
      ),
    );
  }
}

class Dts extends DataTableSource {
  double width;
  double height;
  int? size;
  List? srno;
  BuildContext context;
  List<BranchFullDetails>? branchFullDetails;
  LoginProv? loginProv;
  Dts(this.width, this.height, this.context, this.branchFullDetails,
      this.loginProv);
  String? password;
  String? password2;
  String? error;
  final passwordkey = GlobalKey<FormState>();
  // final keys = Keyy();

  /* Widget actionsRow(CompanyDets companyDets, CompEmailStatus compEmailStatus) {
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
                    .disableCompany(
                        companyDets, compEmailStatus, loginProv.jwtToken);
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
  } */

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
          DataCell(Container(width: width * 0.22, child: Text("${index + 1}"))),
          DataCell(InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Employees(branchId: branchFullDetails![index].id),
                  ));
            },
            child: Container(
                width: width * 0.22,
                child: Text(branchFullDetails![index].name!)),
          )),
          DataCell(Container(
              width: size == 1 ? width * 0.22 : width * 0.2,
              child: Text(branchFullDetails![index].moneyEarned!))),
          DataCell(Container(
              width: size == 1 ? width * 0.26 : width * 0.1,
              child: Text(branchFullDetails![index].contact.toString()))),
          /* DataCell(Container(
              width: size == 1 ? width * 0.15 : width * 0.1,
              child: actionsRow(companyFullDetails.companyDetsList[index],
                  companyFullDetails.compEmailStatusList[index]))) */
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => branchFullDetails!.length;

  @override
  int get selectedRowCount => 0;
}
