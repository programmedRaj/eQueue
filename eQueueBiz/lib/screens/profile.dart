import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/constants/textstyle.dart';
import 'package:equeuebiz/enum/company_enum.dart';
import 'package:equeuebiz/model/bizdetsmo.dart';
import 'package:equeuebiz/providers/auth_prov.dart';
import 'package:equeuebiz/widgets/appbar.dart';
import 'package:equeuebiz/widgets/custom_widgets.dart';
import 'package:equeuebiz/widgets/resize_helper.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  String acn;
  String acnum;
  String bname;
  String descr;
  String earned;
  String id;
  String ifsc;
  String moneyearned;
  String name;
  String profileurl;
  String type;
  Profile(
      {this.acn,
      this.acnum,
      this.bname,
      this.descr,
      this.earned,
      this.id,
      this.ifsc,
      this.moneyearned,
      this.name,
      this.profileurl,
      this.type});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String acn;
  String acnum;
  String bname;
  String descr;
  String earned;
  String id;
  String ifsc;
  String moneyearned;
  String name;
  String profileurl;
  String type;

  @override
  void initState() {
    setState(() {
      acn = widget.acn;
      acnum = widget.acnum;
      bname = widget.bname;
      descr = widget.descr;
      earned = widget.earned;
      id = widget.id;
      ifsc = widget.ifsc;
      name = widget.name;
      profileurl = widget.profileurl;
      type = widget.type;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: whiteAppBar(context, "Profile"),
        body: Container(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1200),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    _photo(profileurl),
                    IgnorePointer(child: _textField("Name", name)),
                    type == 'booking'
                        ? _textField("Acc Name", acn)
                        : SizedBox(),
                    type == 'booking'
                        ? _textField("Acc No", acnum)
                        : SizedBox(),
                    type == 'booking'
                        ? _textField("Bank Name", bname)
                        : SizedBox(),
                    _textField("Description", descr),
                    type == 'booking' ? _textField("Ifsc", ifsc) : SizedBox(),
                    IgnorePointer(child: _textField("Type", type)),
                    addCancel()
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget _photo(String p) {
    return Container(
      width: 100,
      height: 100,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: AppColor.purpleBlue),
      // child: Image.network('$p'),
    );
  }

  Widget _textField(String hintText, String val) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: TextFormField(
        onChanged: (v) {
          setState(() {
            acn = v;
          });
        },
        initialValue: val,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget addCancel() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      height: 50,
      child: Row(
        children: [
          Expanded(child: CustomWidgets().filledButton("Save")),
          SizedBox(
            width: 25,
          ),
          Expanded(child: CustomWidgets().hollowButton("CANCEL"))
        ],
      ),
    );
  }
}
