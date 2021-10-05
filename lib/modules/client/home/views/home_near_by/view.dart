import 'package:flutter/material.dart';
import 'package:gadha/comman/models/responses/places.dart';
import 'package:gadha/widgets/items/shops_near_by.dart';
import 'package:gadha/widgets/signle/center_error.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:shimmer/shimmer.dart';

import 'cubit/home_near_by_cubit.dart';

class HomeNearBy extends StatelessWidget {
  const HomeNearBy({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNearByCubit, HomeNearByState>(
      builder: (context, state) {
        if (state is HomeNearByLoading) {
          return _buildLoader();
        } else if (state is HomeNearByLoaded) {
          if (state.places.isEmpty) {
            return CenterError(message: 'empty'.tr);
          }
          return ListView.builder(
            itemCount: state.places.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) {
              return NearByShop(state.places[index]);
            },
          );
        } else if (state is HomeNearByCant) {
          return _buildLoader();
        }
        return const SizedBox();
      },
    );
  }

  ListView _buildLoader() {
    return ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: const NearByShop(PlaceEntity(name: 'name')),
        );
      },
    );
  }
}
