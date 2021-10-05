import 'package:flutter/material.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/functions.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'cubit/near_by_search_cubit.dart';

class SearchFilter extends StatelessWidget {
  const SearchFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<NearBySearchCubit>(context);
    var val = cubit.searchReadius;
    return SafeArea(
      child: Container(
        height: height * 0.35,
        color: Colors.transparent, //could change this to Color(0xFF737373),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'filter'.tr,
                        style: const TextStyle(
                          color: AppColors.boldBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0.95, 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Theme.of(context).accentColor,
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        cubit.onRadiusChange(val);
                        Q.back();
                      },
                      child: Text(
                        'apply_filter'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(endIndent: 30, indent: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(children: [
                  Text('search_distance'.tr),
                ]),
              ),
              SleekCircularSlider(
                appearance: CircularSliderAppearance(
                    customColors: CustomSliderColors(
                  progressBarColors: [
                    for (var i = 0; i < 2; i++) ...[
                      const Color(0xff9B4DF4),
                      const Color(0xff412582),
                    ]
                  ],
                )),
                min: 1000,
                max: 4000,
                initialValue: val,
                onChange: (double value) => val = value,
                innerWidget: (double value) {
                  return Center(
                    child: Text(
                      '${(value / 1000).toStringAsFixed(1)}km',
                      textDirection: directionReversed,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
