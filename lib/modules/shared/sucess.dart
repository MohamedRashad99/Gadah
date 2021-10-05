import 'package:gadha/widgets/buttons/custom_main_button.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:gadha/widgets/signle/app_bar.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../client/home/page.dart';

class OrderSubmitted extends StatefulWidget {
  const OrderSubmitted({Key? key}) : super(key: key);
  @override
  _OrderSubmittedState createState() => _OrderSubmittedState();
}

class _OrderSubmittedState extends State<OrderSubmitted>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController!, curve: Curves.easeIn));
    Future.delayed(const Duration(milliseconds: 300), () {
      _animationController?.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StanderedAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(child: SuccessMark(_animation)),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text('order_submitted'.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'order_submitted_desc1'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  CustomMainButton(
                    outline: true,
                    text: 'back_to_home_screen'.tr,
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    height: 50,
                    borderRaduis: 10,
                    textSize: 15,
                    onTap: () => Q.replace(const ClientHomePage()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessMark extends AnimatedWidget {
  const SuccessMark(Animation animatedContainer, {Key? key})
      : super(listenable: animatedContainer, key: key);

  double get value => (listenable as Animation).value as double;
  double get valueRev => 1.0 - (listenable as Animation<double>).value;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size.aspectRatio * (150 - 20 * valueRev),
      backgroundColor: ColorTween(begin: Colors.amber, end: Colors.green)
          .evaluate(listenable as Animation<double>),
      child: Opacity(
        opacity: value,
        child: Icon(
          FontAwesomeIcons.check,
          color: Colors.white,
          size: size.aspectRatio * 150,
        ),
      ),
    );
  }
}
