import 'package:equeue_admin/models/branches_full_dets.dart';
import 'package:equeue_admin/models/company_full_details.dart';
import 'package:equeue_admin/models/emp_dets.dart';
import 'package:equeue_admin/pages/add_company_page.dart';
import 'package:equeue_admin/pages/comp_more_opts.dart';
import 'package:equeue_admin/pages/login_page.dart';
import 'package:equeue_admin/providers/branch_prov.dart';
import 'package:equeue_admin/providers/comp_more_opts_prov.dart';
import 'package:equeue_admin/providers/company_full_dets_prov.dart';
import 'package:equeue_admin/providers/emp_prov.dart';
import 'package:equeue_admin/providers/login_prov.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Employees extends StatefulWidget {
  final int? branchId;
  Employees({required this.branchId});
  @override
  _EmployeesState createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
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
    Provider.of<EmpProv>(context, listen: false).getEmployees(widget.branchId);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    loginProv = Provider.of<LoginProv>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Employees"),
      ),
      body: Consumer<EmpProv>(
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
                                  ? "No Employee"
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
                                    Text('Employees'),
                                  ],
                                ),
                                columns: [
                                  DataColumn(label: Text('Sr No.')),
                                  DataColumn(label: Text('Email')),
                                  DataColumn(label: Text('Emp ID')),
                                  DataColumn(label: Text('status')),
                                  //DataColumn(label: Text("Actions"))
                                ],
                                source: Dts(width, height, context,
                                    value.employeeDetsList, loginProv),
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
  List<EmpDets>? empDets;
  LoginProv? loginProv;
  Dts(this.width, this.height, this.context, this.empDets, this.loginProv);
  String? password;
  String? password2;
  String? error;
  final passwordkey = GlobalKey<FormState>();

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
          DataCell(Container(width: width * 0.1, child: Text("${index + 1}"))),
          DataCell(
              Container(width: width * 0.1, child: Text(empDets![index].email!))),
          DataCell(Container(
              width: size == 1 ? width * 0.15 : width * 0.2,
              child: Text(empDets![index].empId.toString()))),
          DataCell(Container(
              width: size == 1 ? width * 0.15 : width * 0.1,
              child: Text(empDets![index].status.toString()))),
          /* DataCell(Container(
              width: size == 1 ? width * 0.15 : width * 0.1,
              child: actionsRow(companyFullDetails.companyDetsList[index],
                  companyFullDetails.compEmailStatusList[index]))) */
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => empDets!.length;

  @override
  int get selectedRowCount => 0;
}
