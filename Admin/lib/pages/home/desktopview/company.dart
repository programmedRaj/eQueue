import 'package:flutter/material.dart';

class Company extends StatefulWidget {
  @override
  _CompanyState createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  int _rowperpage = PaginatedDataTable.defaultRowsPerPage;
  List searchlist = [];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var dts = searchlist == null || searchlist.isEmpty
        ? Dts(width, height, context)
        : Dts(width, height, context);
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  // adduser(width, height);
                },
                child: Text(
                  'Add Company',
                  style: TextStyle(color: Theme.of(context).accentColor),
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
                            decoration: InputDecoration(hintText: 'Search'),
                          )),
                    ],
                  ),
                ],
              ),
              columns: [
                DataColumn(label: Text('Sr No.')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Password')),
                DataColumn(label: Text('Password')),
              ],
              source: dts,
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
  }
}

class Dts extends DataTableSource {
  double width;
  double height;
  int size;
  List srno;
  BuildContext context;
  Dts(this.width, this.height, this.context);
  String password;
  String password2;
  String error;
  final passwordkey = GlobalKey<FormState>();
  // final keys = Keyy();
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Container(width: width * 0.1, child: Text('1'))),
      DataCell(Container(width: width * 0.1, child: Text('name'))),
      DataCell(Container(
          width: size == 1 ? width * 0.15 : width * 0.2,
          child: Text('password'))),
      DataCell(Container(
          width: size == 1 ? width * 0.15 : width * 0.1, child: Text('date'))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 10;

  @override
  int get selectedRowCount => 0;
}
