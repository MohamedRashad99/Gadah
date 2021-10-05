import 'package:flutter/material.dart';
import 'package:flutter_show_more/flutter_show_more.dart';
import 'package:gadha/comman/models/responses/places.dart';
import 'package:gadha/modules/client/place_profile/cubit/place_profile_cubit.dart';
import 'package:gadha/widgets/signle/app_bar.dart';
import 'package:queen/queen.dart';

class PlaceProfileAppBar extends StatelessWidget {
  final PlaceEntity place;
  const PlaceProfileAppBar(this.place, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: StanderedAppBar(
        appBarType: AppBarType.navigator,
        centerChild: ShowMoreText(
          place.name,
          maxLength: 33,
          showMoreText: '',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
        ),
        trailingActions: <Widget>[
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: BlocProvider.of<PlaceProfileCubit>(context).sharePlace,
              child: const Icon(
                FontAwesomeIcons.shareAlt,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
