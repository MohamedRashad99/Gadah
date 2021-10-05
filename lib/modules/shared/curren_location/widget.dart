import 'package:flutter/material.dart';
import 'package:queen/queen.dart';
import 'package:gadha/comman/config/colors.dart';

import 'cubit/current_location_cubit.dart';

class MyCurrentLocation extends StatelessWidget {
  final Color? textColor;

  const MyCurrentLocation({Key? key, this.textColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentLocationCubit, CurrentLocationState>(
      builder: (context, state) {
        if (state is CurrentLocationLoading) {
          return const SizedBox();
        } else if (state is CurrentLocationError) {
          return Text(state.error);
        } else if (state is CurrentLocationLoaded) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: width * .60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.location,
                    maxLines: 2,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: TextStyle(
                      color: textColor ?? AppColors.darkGreenAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 0.5,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    FontAwesomeIcons.mapMarkerAlt,
                    color: AppColors.darkGreenAccent,
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
