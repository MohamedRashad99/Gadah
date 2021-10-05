import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:gadha/modules/client/search/page.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

class HomeSearchTextField extends StatelessWidget {
  const HomeSearchTextField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Q.to(SearchPage()),
      child: _buildSearchTextField(),
    );
  }

  Widget _buildSearchTextField() {
    return Hero(
      tag: 'ValueKey(5)',
      child: Container(
        height: height * .050,
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Theme(
          data: ThemeData(
            primaryColor: AppColors.lightBlack,
            primaryColorDark: AppColors.lightBlueAccent,
          ),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Material(
              child: TextField(
                enabled: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                  hintText: 'search'.tr,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: AppColors.lightBlack,
                  ),
                  prefixIcon: const Icon(
                    FontAwesomeIcons.search,
                    size: 18,
                    color: AppColors.darkGreenAccent,
                  ),
                  focusColor: AppColors.lightBlack,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.teal,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          height: 35,
                          width: 1,
                          color: Colors.grey[300],
                          margin: const EdgeInsets.only(left: 10, right: 10),
                        ),
                        SvgPicture.asset(
                          Constants.searchFilter,
                          color: AppColors.darkGreenAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
