import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/constants/textstyle.dart';
import 'package:equeuebiz/model/branch_resp_model.dart';
import 'package:equeuebiz/providers/auth_prov.dart';
import 'package:equeuebiz/providers/branches_data_prov.dart';
import 'package:equeuebiz/providers/create_edit_prov.dart';
import 'package:equeuebiz/screens/create_branch_mob.dart';
import 'package:equeuebiz/screens/create_branch_web.dart';
import 'package:equeuebiz/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

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
              LocaleKeys.Branches,
              style: TextStyle(color: Colors.black),
            ).tr(),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateBranchMob(),
                        ));
                  },
                  icon: Icon(
                    Icons.add,
                    size: 28,
                    color: AppColor.mainBlue,
                  ))
            ],
          ),
          body: Container(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(maxWidth: 1200, maxHeight: size.height),
                child: SingleChildScrollView(
                    child: value.isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : value.error
                            ? Center(
                                child: Text(
                                    '${LocaleKeys.NO.tr()} ${LocaleKeys.Branches.tr()}'))
                            : Container(
                                height: size.height,
                                child: ListView.builder(
                                    itemCount: value.branchesWithDetail?.length,
                                    itemBuilder: (context, index) =>
                                        _branchCard(
                                            branchName: value
                                                .branchesWithDetail[index]
                                                .branchName,
                                            branchId: value
                                                .branchesWithDetail[index]
                                                .branchId,
                                            jwtToken:
                                                authProv.authinfo.jwtToken,
                                            branchDets:
                                                value.branchesWithDetail[index],
                                            profile_url:
                                                value.branchWithImages[index],
                                            address1: value
                                                .branchesWithDetail[index]
                                                .addr1,
                                            address2: value
                                                .branchesWithDetail[index]
                                                .addr2,
                                            city: value
                                                .branchesWithDetail[index].city,
                                            province: value
                                                .branchesWithDetail[index]
                                                .province,
                                            countrycode: value
                                                .branchesWithDetail[index]
                                                .postalCode,
                                            phone: value
                                                .branchesWithDetail[index]
                                                .phoneNo)),
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

                    ),
              )),
        );
      },
    );
  }

  Widget _createBranchCard() {
    return InkWell(
      onTap: () {},
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
                  LocaleKeys.Create_Branch,
                  style: TextStyle(color: Colors.white, fontSize: 35),
                ).tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _branchCard(
      {String branchName,
      int branchId,
      String jwtToken,
      BranchRespModel branchDets,
      String profile_url,
      String address1,
      String address2,
      String province,
      String city,
      String countrycode,
      String phone}) {
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
                '$address1 \n $address2\n $province \n , $city \n $countrycode'),
            Divider(),
            Text(
              "$profile_url",
              style: TextStyle(color: AppColor.mainBlue),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  "$phone",
                  style: TextStyle(),
                ),
                Spacer(),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateBranchMob(
                              images: '$profile_url',
                              branchDets: branchDets,
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
                              jwtToken, branchId, branchName, branchDets);
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
