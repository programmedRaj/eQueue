import 'package:easy_localization/easy_localization.dart';
import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/translations/locale_keys.g.dart';
import 'package:equeuebiz/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:equeuebiz/providers/mybiztrans.dart';

class TransactionDets extends StatefulWidget {
  final String? id;
  const TransactionDets({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  _TransactionDetsState createState() => _TransactionDetsState();
}

class _TransactionDetsState extends State<TransactionDets> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<Biztrans>(context, listen: false).biztrans(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<Biztrans>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: whiteAppBar(context, 'Transaction') as PreferredSizeWidget?,
          body: value.trans == null || value.trans.length == 0
              ? Container(
                  child: Center(
                    child: Text('No Transactions'),
                  ),
                )
              : ListView.builder(
                  itemCount: value.trans.length,
                  itemBuilder: (context, i) {
                    return Container(
                      height: height * 0.15,
                      width: width,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          'Transaction Id : ${value.trans[i].txnid}',
                          style: TextStyle(
                              color: AppColor.mainBlue,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Amount : ${value.trans[i].amount}'),
                        trailing: value.trans[i].status == "green"
                            ? CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.green,
                                child: Text(
                                  'S',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )
                            : CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.red,
                                child: Text(
                                  'F',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                      ),
                    );
                  }),
        );
      },
    );
  }
}
