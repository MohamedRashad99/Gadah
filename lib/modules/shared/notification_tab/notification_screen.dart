import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/modules/shared/notification_tab/modes/notifications.dart';
import 'package:gadha/widgets/items/notification_item.dart';
import 'package:gadha/widgets/signle/adaptive_progress_indicator.dart';
import 'package:gadha/widgets/signle/center_error.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/widgets/signle/app_bar.dart';

import 'package:shimmer/shimmer.dart';

import 'cubit/notifications_cubit.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StanderedAppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            StanderedAppBar(
              appBarType: AppBarType.navigator,
              leading: Container(),
              centerChild: Text(
                'notifications'.tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: height * .05,
              width: width,
              child: TextButton.icon(
                onPressed: NotificationsCubit.of(context).refresh,
                icon: const Icon(FontAwesomeIcons.redoAlt,
                    size: 12, color: AppColors.darkGreen),
                label: Text(
                  'refresh'.tr,
                  style: const TextStyle(
                    color: AppColors.darkGreen,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<NotificationsCubit, NotificationsState>(
                builder: (context, state) {
                  if (state is NotificationsLoading) {
                    return ListView.builder(
                      itemCount: 10,
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05, vertical: 20),
                      itemBuilder: (_, i) => _buildLoading(size),
                    );
                  } else if (state is NotificationsEmpty) {
                    return CenterError(
                      icon: FontAwesomeIcons.bellSlash,
                      message: 'no_notifications'.tr,
                      callback: NotificationsCubit.of(context).refresh,
                    );
                  } else if (state is NotificationsLoaded) {
                    return buildContent(state.notifications);
                  } else if (state is NotificationsLoadingMore) {
                    return buildContent(state.notifications, isLoadingMore: true);
                  } else if (state is NotificationsCant) {
                    return CenterError(
                      icon: FontAwesomeIcons.bellSlash,
                      message: 'no_notifications'.tr,
                      callback: NotificationsCubit.of(context).refresh,
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContent(
    List<NotificationModel> notifications, {
    bool isLoadingMore = false,
  }) {
    return RefreshIndicator(
      onRefresh: () async => NotificationsCubit.of(context).refresh(),
      child: ListView.builder(
          itemCount: notifications.length,
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05)
              .add(const EdgeInsets.only(bottom: 30)),
          itemBuilder: (context, index) {
            final cubit = NotificationsCubit.of(context);
            final item = notifications[index];
            final itemWidget = NotificationItem(
              index: index,
              notification: item,
              onDismissed: (_) {},
            );
            final isLastItem = notifications.length == index + 1;
            if (isLastItem && cubit.canLoadMore && !isLoadingMore) {
              cubit.loadMore();
            }
            if (isLastItem && isLoadingMore) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [itemWidget, const CenterLoading()],
              );
            }
            return itemWidget;
          }),
    );
  }

  Container _buildLoading(Size size) {
    return Container(
      height: height * 0.09,
      width: width * 0.95,
      margin: const EdgeInsets.only(bottom: 20),
      child: Container(
        height: height * 0.09,
        width: width * 0.95,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              spreadRadius: 0.05,
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: ListTile(
            dense: false,
            leading: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              // child: const CircleAvatar(
              //   radius: 25,
              //   // backgroundColor: Colors.teal,
              //   // backgroundImage: NetworkImage('https://saudigazette.com.sa/uploads/images/2019/07/06/1289357.jpg'),
              // ),
              child: const SizedBox(),
            ),
            title: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 50,
                  height: 10,
                  color: Colors.grey,
                ),
              ),
            ),
            subtitle: SizedBox(
              width: size.width * 0.4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 20,
                    height: 10,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            trailing: Container(
              width: 20,
            ),
          ),
        ),
      ),
    );
  }
}
