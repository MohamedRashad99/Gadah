import 'package:flutter/material.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/enums.dart';
import 'package:queen/queen.dart';

class PaymentOptionsRow extends StatefulWidget {
  final PaymentMethods paymentMethods;
  final ValueChanged<PaymentMethods> onChoose;

  const PaymentOptionsRow(
      {required this.onChoose,
      this.paymentMethods = PaymentMethods.cash,
      Key? key})
      : super(key: key);

  @override
  _PaymentOptionsRowState createState() => _PaymentOptionsRowState();
}

class _PaymentOptionsRowState extends State<PaymentOptionsRow> {
  late PaymentMethods _paymentMethods;
  PaymentMethods get paymentMethods => _paymentMethods;
  set paymentMethods(PaymentMethods? p) {
    setState(() => _paymentMethods = p!);
    widget.onChoose(_paymentMethods);
  }

  @override
  void initState() {
    paymentMethods = widget.paymentMethods;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width,
        height: size.height * 0.07,
        padding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: size.width * 0.08,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: () => paymentMethods = PaymentMethods.cash,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('cash',
                      style:
                          TextStyle(color: AppColors.boldBlack, fontSize: 17)),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: width * 0.05,
                    height: width * 0.05,
                    child: Radio<PaymentMethods>(
                      value: PaymentMethods.cash,
                      groupValue: paymentMethods,
                      onChanged: (_) => paymentMethods = _,
                    ),
                  ),
                ],
              ),
            ),
            // InkWell(
            //   onTap: () => paymentMethods = PaymentMethods.visa,
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: <Widget>[
            //       const FaIcon(FontAwesomeIcons.ccVisa, color: Colors.blue),
            //       const SizedBox(width: 10),
            //       SizedBox(
            //         width: width * 0.05,
            //         height: width * 0.05,
            //         child: Radio<PaymentMethods>(
            //           value: PaymentMethods.visa,
            //           groupValue: paymentMethods,
            //           onChanged: (_) => paymentMethods = _,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // InkWell(
            //   onTap: () => paymentMethods = PaymentMethods.stcPay,
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: <Widget>[
            //       Image.asset(
            //         Constants.stcPayPNG,
            //         height: 30,
            //         width: 60,
            //         color: Colors.black,
            //       ),
            //       const SizedBox(width: 0),
            //       SizedBox(
            //         width: size.width * 0.05,
            //         height: size.width * 0.05,
            //         child: Radio<PaymentMethods>(
            //           value: PaymentMethods.stcPay,
            //           groupValue: paymentMethods,
            //           onChanged: (_) => paymentMethods = _,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ));
  }
}
