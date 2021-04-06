import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/constants/textstyle.dart';
import 'package:equeuebiz/model/branch_resp_model.dart';
import 'package:equeuebiz/providers/auth_prov.dart';
import 'package:equeuebiz/providers/branches_data_prov.dart';
import 'package:equeuebiz/providers/create_edit_prov.dart';
import 'package:equeuebiz/screens/create_branch_mob.dart';
import 'package:equeuebiz/screens/create_branch_web.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Branches extends StatefulWidget {
  @override
  _BranchesState createState() => _BranchesState();
}

class _BranchesState extends State<Branches> {
  AuthProv authProv;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<BranchDataProv>(context, listen: false)
          .getbranchesWithDetail(authProv.authinfo.jwtToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    authProv = Provider.of<AuthProv>(context);
    return Consumer<BranchDataProv>(
      builder: (context, value, child) {
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
              "Branches",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Container(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(maxWidth: 1200, maxHeight: size.height),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _createBranchCard(),
                      value.isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : value.error
                              ? Center(
                                  child:
                                      Text("Error occured while fetching data"))
                              : Container(
                                  height: size.height,
                                  child: ListView.builder(
                                      itemCount:
                                          value.branchesWithDetail?.length,
                                      itemBuilder: (context, index) =>
                                          _branchCard(
                                              value.branchesWithDetail[index]
                                                  .branchName,
                                              value.branchesWithDetail[index]
                                                  .branchId,
                                              authProv.authinfo.jwtToken,
                                              value.branchesWithDetail[index])),
                                )
                      /* Text("No branches to show ."),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateBranch(),
                        ));
                  },
                  child: Text("Create Branch"),
                  style: ButtonStyle(),
                ) */
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }

  Widget _createBranchCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateBranchMob(),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: AppColor.mainBlue,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 3)]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  "Create Branch",
                  style: TextStyle(color: Colors.white, fontSize: 35),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _branchCard(String branchName, int branchId, String jwtToken,
      BranchRespModel _branchDets) {
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
            Text(
              "$branchName",
              style: blackBoldFS16,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                "Branch desc  sn FVA Srb jfr h,j j fj<JF,j ,jfjw sfjs fjawe,jf jwe fje wfjw fjbfbr,rfb smdfvsdhcbSEBDF<cbs,edc,E<DJCb,jSBDC< SD<C S<JD JC S<JDBC<JSB<JC "),
            Divider(),
            Text(
              "Something -- Someting",
              style: TextStyle(color: AppColor.mainBlue),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  "Something ",
                  style: TextStyle(),
                ),
                Spacer(),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateBranchMob(
                              branchDets: _branchDets,
                            ),
                          ));
                    },
                    child: Icon(Icons.edit)),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                    onTap: () async {
                      bool success = await Provider.of<BranchDataProv>(context,
                              listen: false)
                          .execDeleteBranch(
                              jwtToken, branchId, branchName, _branchDets);
                      if (success) {
                        Provider.of<BranchDataProv>(context, listen: false)
                            .getbranchesWithDetail(jwtToken);
                      }
                    },
                    child: Icon(Icons.delete))
              ],
            )
          ],
        ),
      ),
    );
  }
}
