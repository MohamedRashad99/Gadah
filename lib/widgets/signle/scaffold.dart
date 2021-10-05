import 'package:flutter/material.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:queen/queen.dart';
import 'package:flutter_svg/svg.dart';

import 'app_bar.dart';

class GadhaScaffold extends StatelessWidget {
  final List<Widget> children;
  final String title;
  const GadhaScaffold({required this.children, required this.title, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const StanderedAppBar(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.25,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        child: Container(
                          height: height * 0.25,
                          decoration: BoxDecoration(
                            gradient: AppColors.famousGradient(
                              end: Alignment.centerRight,
                              begin: Alignment.centerLeft,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -90,
                        right: -15,
                        child: SvgPicture.asset(
                          Constants.logoWaterMark,
                          height: height * 0.35,
                          width: width * 0.9,
                        ),
                      ),
                      Positioned(
                        top: height * 0.18,
                        left: 0,
                        right: 0,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              shadows: [
                                Shadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      width * 0.06, width * 0.05, width * 0.06, 0),
                  child: Column(children: children),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
