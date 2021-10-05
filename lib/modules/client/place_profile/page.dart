import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gadha/comman/models/responses/places.dart';
import 'package:gadha/widgets/signle/app_bar.dart';
import 'package:queen/queen.dart';

import 'cubit/place_profile_cubit.dart';
import 'views/app_bar.dart';
import 'views/body.dart';
import 'views/fab.dart';

class ServiceShopProfile extends StatelessWidget {
  final PlaceEntity place;
  final String? coverImageUrl;

  const ServiceShopProfile({
    required this.place,
    this.coverImageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlaceProfileCubit(place),
      child: Builder(
        builder: (BuildContext context) => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: const StanderedAppBar(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: PlaceProfileFab(
              coverImageUrl: coverImageUrl,
            ),
            body: Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    PlaceProfileAppBar(place),
                    PlaceProfileBody(coverImageUrl: coverImageUrl),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
