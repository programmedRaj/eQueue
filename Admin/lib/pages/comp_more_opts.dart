import 'package:equeue_admin/models/add_company.dart';
import 'package:equeue_admin/models/company_full_details.dart';
import 'package:equeue_admin/pages/add_company_page.dart';
import 'package:equeue_admin/providers/comp_more_opts_prov.dart';
import 'package:equeue_admin/providers/login_prov.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompMoreOpts extends StatefulWidget {
  final CompanyDets companyDets;
  final CompEmailStatus compEmailStatus;
  CompMoreOpts({required this.companyDets, required this.compEmailStatus});
  @override
  _CompMoreOptsState createState() => _CompMoreOptsState();
}

class _CompMoreOptsState extends State<CompMoreOpts> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<CompMoreOptsProv>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.companyDets.name!),
      ),
      body: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(maxWidth: 1200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  /*  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCompanyPage(
                          compEmailStatus: widget.compEmailStatus,
                          companyDets: widget.companyDets,
                        ),
                      )); */
                },
                child: Text("EDIT")),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  bool success = await prov.disableCompany(
                      widget.companyDets,
                      widget.compEmailStatus,
                      Provider.of<LoginProv>(context, listen: false).jwtToken);
                  if (success) {
                    Navigator.pop(context);
                  }
                },
                child: widget.compEmailStatus.status == 1
                    ? Text("DISABLE")
                    : Text("ENABLE")),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  bool success = await prov.deleteCompany(
                      widget.companyDets, widget.compEmailStatus);
                  if (success) {
                    Navigator.pop(context);
                  }
                },
                child: Text("DELETE")),
          ],
        ),
      ),
    );
  }
}
