import 'package:equeue_admin/models/company_full_details.dart';
import 'package:equeue_admin/models/user_dets.dart';
import 'package:equeue_admin/pages/add_company_page.dart';
import 'package:equeue_admin/pages/comp_more_opts.dart';
import 'package:equeue_admin/pages/home/desktopview/branch.dart';
import 'package:equeue_admin/pages/login_page.dart';
import 'package:equeue_admin/providers/comp_more_opts_prov.dart';
import 'package:equeue_admin/providers/company_full_dets_prov.dart';
import 'package:equeue_admin/providers/login_prov.dart';
import 'package:equeue_admin/providers/user_prov.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
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
    Provider.of<UserProv>(context, listen: false).getUsers();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    loginProv = Provider.of<LoginProv>(context);
    /* var dts = searchlist == null || searchlist.isEmpty
        ? Dts(width, height, context , )
        : Dts(width, height, context); */
    return Consumer<UserProv>(
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
                            value.isEmpty ? "No users" : "Something went wrong",
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
                                  Text('Users'),
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
                                DataColumn(label: Text('money')),
                                DataColumn(label: Text('Contact')),
                                DataColumn(label: Text("Actions"))
                              ],
                              source: Dts(width, height, context,
                                  value.userDetsList, loginProv),
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
    );
  }
}

class Dts extends DataTableSource {
  double width;
  double height;
  int? size;
  List? srno;
  BuildContext context;
  List<UserDets>? userDets;
  LoginProv? loginProv;
  Dts(this.width, this.height, this.context, this.userDets, this.loginProv);
  String? password;
  String? password2;
  String? error;
  final passwordkey = GlobalKey<FormState>();
  // final keys = Keyy();

  Widget actionsRow(UserDets userDets) {
    return Row(
      children: [
        /* InkWell(
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
        ), */
        /* InkWell(
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
        ), */
        InkWell(
          onTap: () async {
            bool success = await Provider.of<UserProv>(context, listen: false)
                .deleteUser(userDets);
            if (success) {
              Provider.of<UserProv>(context, listen: false).getUsers();
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
          DataCell(Container(width: width * 0.1, child: Text("${index + 1}"))),
          DataCell(InkWell(
            onTap: () {},
            child: Container(
                width: width * 0.1, child: Text(userDets![index].name!)),
          )),
          DataCell(Container(
              width: size == 1 ? width * 0.15 : width * 0.2,
              child: Text(userDets![index].money!))),
          DataCell(Container(
              width: size == 1 ? width * 0.15 : width * 0.1,
              child: Text(userDets![index].contact.toString()))),
          DataCell(Container(
              width: size == 1 ? width * 0.15 : width * 0.1,
              child: actionsRow(userDets![index]))),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => userDets!.length;

  @override
  int get selectedRowCount => 0;
}
