import 'package:eQueue/components/color.dart';
import 'package:eQueue/constants/apptoast.dart';
import 'package:eQueue/provider/paymentdone.dart';
import 'package:eQueue/screens/pages/walletpage/stripe-pay.dart';
import 'package:eQueue/screens/pages/walletpage/wallet_page.dart';
import 'package:eQueue/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:easy_localization/easy_localization.dart';

class ExistingCardsPage extends StatefulWidget {
  ExistingCardsPage({Key key}) : super(key: key);
  @override
  ExistingCardsPageState createState() => ExistingCardsPageState();
}

class ExistingCardsPageState extends State<ExistingCardsPage> {
  String amount = "1";

  Future payViaNewCard(BuildContext context, String amount) async {
    var amt = int.parse(amount) * 100;
    var response = await StripeService.payWithNewCard(
        amount: amt.toString(), currency: 'USD');

    print(response.success);
    if (response.success) {
      await Provider.of<PaymentDoneProvider>(context, listen: false)
          .paymentdone(amount: amount, status: response.success)
          .then((value) {
        if (value == 200) {
          AppToast.showSucc(LocaleKeys.PaymentDone.tr());
          Navigator.of(context).pop();
          // .push(MaterialPageRoute(builder: (ctx) => Wallet()));
        } else {
          AppToast.showErr(LocaleKeys.Somethingwentwrong.tr());
        }
      });
    } else {
      AppToast.showErr(LocaleKeys.PaymentFailed.tr());
    }

    // Scaffold.of(context).showSnackBar(SnackBar(
    //     content: Text(response.message),
    //     duration: new Duration(
    //         milliseconds: response.success == true ? 1200 : 3000)));
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  payViaExistingCard(BuildContext context, card) async {
    var expiryArr = card['expiryDate'].split('/');
    CreditCard stripeCard = CreditCard(
      number: card['cardNumber'],
      expMonth: int.parse(expiryArr[0]),
      expYear: int.parse(expiryArr[1]),
    );
    var response = await StripeService.payViaExistingCard(
        amount: '2500', currency: 'INR', card: stripeCard);

    Scaffold.of(context)
        .showSnackBar(SnackBar(
          content: Text(response.message),
          duration: new Duration(milliseconds: 1200),
        ))
        .closed
        .then((_) {
      // Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.Payment).tr(),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         payViaNewCard(context);
          //       },
          //       icon: Icon(Icons.add))
          // ],
        ),
        body: Container(
          margin: EdgeInsets.all(40),
          decoration: BoxDecoration(
              color: myColor[100],
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[600],
                  blurRadius: 0.6,
                )
              ]),
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 40, bottom: 20),
                child: RadioButtonGroup(
                  orientation: GroupedButtonsOrientation.HORIZONTAL,
                  margin: const EdgeInsets.only(left: 12.0),
                  onSelected: (String selected) => setState(() {
                    amount = selected;
                    print(selected);
                  }),
                  labels: <String>["10", "20", "50", "100"],
                  picked: amount,
                  itemBuilder: (Radio rb, Text txt, int i) {
                    return Column(
                      children: <Widget>[
                        Icon(Icons.public),
                        rb,
                        txt,
                      ],
                    );
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (amount != null || amount != '0') {
                      payViaNewCard(context, amount);
                    } else {
                      AppToast.showErr(LocaleKeys.EnterAmount.tr());
                    }
                  },
                  child: Text(LocaleKeys.addmoney).tr())
            ],
          ),
        ));
  }
}
