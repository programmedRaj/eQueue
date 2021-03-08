import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/constants/textstyle.dart';
import 'package:equeuebiz/screens/create_branch.dart';
import 'package:flutter/material.dart';

class Branches extends StatefulWidget {
  @override
  _BranchesState createState() => _BranchesState();
}

class _BranchesState extends State<Branches> {
  @override
  Widget build(BuildContext context) {
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
            constraints: BoxConstraints(maxWidth: 1200),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _createBranchCard(),
                  _branchCard(),
                  _branchCard(),
                  _branchCard()
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
  }

  Widget _createBranchCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateBranch(),
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

  Widget _branchCard() {
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
              "Branch Name",
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
                Icon(Icons.edit),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.delete)
              ],
            )
          ],
        ),
      ),
    );
  }
}
