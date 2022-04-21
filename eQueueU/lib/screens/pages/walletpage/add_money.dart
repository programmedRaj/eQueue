import 'dart:convert';

import 'package:eQueue/components/color.dart';
import 'package:eQueue/provider/paymentdone.dart';
import 'package:eQueue/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons_ns/grouped_buttons_ns.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

class ExistingCardsPage extends StatefulWidget {
  const ExistingCardsPage({Key? key}) : super(key: key);

  @override
  _ExistingCardsPageState createState() => _ExistingCardsPageState();
}

class _ExistingCardsPageState extends State<ExistingCardsPage> {
  static String secret =
      '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';
  String? amount = '10';

  Map<String, dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Now'),
      ),
      body: Column(
        children: [
          Center(
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
                    rb,
                    txt,
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () async {
              await makePayment();
            },
            child: Container(
              height: 50,
              width: 200,
              color: myColor[150],
              child: Center(
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent(
          amount!, 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'ANNIE'))
          .then((value) {});

      ///now finally display payment sheeet

      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        Provider.of<PaymentDoneProvider>(context, listen: false).paymentdone(
          amount: amount,
          status: true,
        );

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(LocaleKeys.PaymentDone.tr())));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        Provider.of<PaymentDoneProvider>(context, listen: false).paymentdone(
          amount: amount,
          status: false,
        );

        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(LocaleKeys.PaymentFailed.tr())));
      });
    } on StripeException catch (e) {
      Provider.of<PaymentDoneProvider>(context, listen: false).paymentdone(
        amount: amount,
        status: false,
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(LocaleKeys.PaymentFailed.tr())));
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
      Provider.of<PaymentDoneProvider>(context, listen: false).paymentdone(
        amount: amount,
        status: false,
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(LocaleKeys.PaymentFailed.tr())));
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer $secret',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
