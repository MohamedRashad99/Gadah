import 'package:flutter/material.dart';

import 'package:gadha/comman/models/order.dart';
import 'package:flutter_show_more/flutter_show_more.dart';
import 'package:gadha/comman/models/offer.dart';
import 'package:gadha/modules/client/order_offers/cubit/user_offers_cubit.dart';
import 'package:gadha/modules/client/order_offers/offer_item.dart';
import 'package:gadha/widgets/signle/app_bar.dart';
import 'package:gadha/widgets/signle/center_error.dart';
import 'package:gadha/widgets/signle/adaptive_progress_indicator.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

class ClientOrderOfferTab extends StatelessWidget {
  final OrderEntity orderEntity;
  const ClientOrderOfferTab(
    this.orderEntity, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: BlocProvider(
              create: (_) => UserOffersCubit(orderEntity),
              child: Builder(
                builder: (_) => BlocBuilder<UserOffersCubit, UserOffersState>(
                  builder: (context, state) {
                    if (state is UserOffersError) {
                      return CenterError.err(
                        state.msg,
                        callback: UserOffersCubit.of(context).refresh,
                      );
                    } else if (state is UserOffersLoading) {
                      return const CenterLoading();
                    } else if (state is UserOffersLoaded) {
                      return buildItems(offers: state.offers, context: context);
                    } else if (state is UserOffersIsEmpty) {
                      return CenterError(
                        message: 'no_offers'.tr,
                        callback: UserOffersCubit.of(context).refresh,
                        buttonText: 'refresh'.tr,
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ),
          // Container(color: Colors.white, width: width, height: height * 0.06),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Material(
      color: Colors.transparent,
      child: StanderedAppBar(
        leading: const SizedBox(),
        centerChild: ShowMoreText(
          'my_offers'.tr,
          maxLength: 33,
          showMoreText: '',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildItems({
    required List<OfferEntity> offers,
    required BuildContext context,
  }) {
    final cubit = UserOffersCubit.of(context);
    return RefreshIndicator(
      onRefresh: cubit.refresh,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: offers.length,
        itemBuilder: (_, int index) {
          final item = offers[index];
          return OfferItem(item, orderEntity.id);
        },
      ),
    );
  }
}
