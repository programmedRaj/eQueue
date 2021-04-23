import 'package:eQueue/components/color.dart';
import 'package:eQueue/provider/transaction_provider.dart';
import 'package:eQueue/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class TransactionDets extends StatefulWidget {
  @override
  _TransactionDetsState createState() => _TransactionDetsState();
}

class _TransactionDetsState extends State<TransactionDets> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<TransactionProvider>(context, listen: false).displaytrans();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<TransactionProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.Transaction).tr(),
          ),
          body: value.trans == null || value.trans.length == 0
              ? Container(
                  child: Center(
                    child: Text(LocaleKeys.NoTransactions).tr(),
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
                        color: myColor[100],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          '${LocaleKeys.TransactionID.tr()} : ${value.trans[i].tid}',
                          style: TextStyle(
                              color: myColor[250], fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            '${LocaleKeys.Amount.tr()} : ${value.trans[i].amount}'),
                        trailing: value.trans[i].status == "success"
                            ? CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.green,
                                child: Text(
                                  'S',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: myColor[100]),
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
                                      color: myColor[100]),
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
