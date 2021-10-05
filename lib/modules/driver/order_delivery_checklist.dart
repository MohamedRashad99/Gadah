import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/widgets/buttons/custom_main_button.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:gadha/comman/config/colors.dart';

class OrderAgentSaftyCheckList extends StatelessWidget {
  const OrderAgentSaftyCheckList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _instructionsList = <String>[
      'be_sure_of_the_client'.tr,
      'drive_slowly_and_safely'.tr,
      'ware_your_gloves_mask'.tr,
      'revieve_your_money_first'.tr,
    ];
    final _instructionsIconsList = <IconData>[
      FontAwesomeIcons.handshake,
      FontAwesomeIcons.car,
      FontAwesomeIcons.mitten,
      FontAwesomeIcons.handHoldingUsd,
    ];
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.06, vertical: 20),
        height: size.height * 0.45,
        width: size.width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'follow_safty_instructions'.tr,
              style: const TextStyle(
                color: AppColors.boldBlack,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        _instructionsIconsList[index],
                        color: AppColors.lightGreen,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        _instructionsList[index],
                        style: const TextStyle(
                          color: AppColors.boldBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                if (index == _instructionsList.length - 1) {
                  return Container();
                }
                return const Divider();
              },
              itemCount: _instructionsList.length,
            ),
            // Spacer(),
            CustomMainButton(
              onTap: () =>
                  Navigator.of(context, rootNavigator: true).pop<bool>(true),
              text: 'start_your_trip'.tr,
              padding: const EdgeInsets.symmetric(vertical: 12),
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}

// class OrderAgentSaftyCheckList extends StatelessWidget {
//   const OrderAgentSaftyCheckList({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final _instructionsList = <String>[
//       'be_sure_of_the_client'.tr,
//       'drive_slowly_and_safely'.tr,
//       'ware_your_gloves_mask'.tr,
//       'revieve_your_money_first'.tr,
//     ];
//     final List<IconData> _instructionsIconsList = [
//       FontAwesomeIcons.handshake,
//       FontAwesomeIcons.car,
//       FontAwesomeIcons.mitten,
//       FontAwesomeIcons.handHoldingUsd,
//     ];
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: size.width * 0.06, vertical: 20),
//         // height: size.height * 0.45,
//         width: size.width * 0.9,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Text(
//               'follow_safty_instructions'.tr,
//               style: const TextStyle(
//                 color: AppColors.boldBlack,
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10),
//             ListView.separated(
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   child: Row(
//                     children: <Widget>[
//                       Icon(
//                         _instructionsIconsList[index],
//                         color: AppColors.lightGreen,
//                       ),
//                       const SizedBox(width: 20),
//                       Text(
//                         _instructionsList[index],
//                         style: const TextStyle(
//                           color: AppColors.boldBlack,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 13,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               separatorBuilder: (context, index) {
//                 if (index == _instructionsList.length - 1) {
//                   return Container();
//                 }
//                 return const Divider();
//               },
//               itemCount: _instructionsList.length,
//             ),
//             // Spacer(),
//             CustomMainButton(
//               onTap: () => Navigator.of(context, rootNavigator: true).pop<bool>(true),
//               text: 'start_your_trip'.tr,
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               textSize: 12,
//               fontWeight: FontWeight.bold,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
