import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/modules/shared/complains/models/complain.dart';
import 'package:gadha/modules/shared/complains/cubit/complains_cubit.dart';
import 'package:gadha/widgets/signle/adaptive_progress_indicator.dart';
import 'package:gadha/widgets/signle/center_error.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:gadha/widgets/signle/app_bar.dart';

import 'package:shimmer/shimmer.dart';

import 'create_one_dialog.dart';
import 'item.dart';

class ComplainsScreen extends StatefulWidget {
  final OrderEntity? orderEntity;

  const ComplainsScreen({Key? key, this.orderEntity}) : super(key: key);
  @override
  _ComplainsScreenState createState() => _ComplainsScreenState();
}

class _ComplainsScreenState extends State<ComplainsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StanderedAppBar(),
      floatingActionButton: widget.orderEntity == null
          ? null
          : FloatingActionButton(
              onPressed: () => Q.dialog(
                  CreateComplaintDialog(orderEntity: widget.orderEntity)),
              child: const Icon(Icons.add, color: Colors.white),
            ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            StanderedAppBar(
              appBarType: AppBarType.navigatorExtended,
              centerChild: Text(
                'complaints'.tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<ComplainsCubit, ComplainsState>(
                builder: (context, state) {
                  if (state is ComplainsLoading) {
                    return ListView.builder(
                      itemCount: 10,
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05, vertical: 20),
                      itemBuilder: (_, i) => _buildLoading(size),
                    );
                  } else if (state is ComplainsEmpty) {
                    return CenterError(
                      icon: FontAwesomeIcons.smileBeam,
                      message: 'no_complains'.tr,
                      callback: ComplainsCubit.of(context).refresh,

                      //   onReload: ComplainsCubit.of(context).refresh,
                    );
                  } else if (state is ComplainsLoadingMore) {
                    return buidContent(state.complains, isLodingMore: true);
                  } else if (state is ComplainsLoaded) {
                    return buidContent(state.complains);
                  } else if (state is ComplainsCatLoad) {
                    return CenterError(
                      icon: FontAwesomeIcons.bellSlash,
                      message: state.msg,
                      callback: ComplainsCubit.of(context).refresh,

                      /*buttomText: 'refresh'.tr,
                      onReload: ComplainsCubit.of(context).refresh,*/
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

  Widget buidContent(
    List<ComplianEntity> complaints, {
    bool isLodingMore = false,
  }) {
    return RefreshIndicator(
      onRefresh: () async => ComplainsCubit.of(context).refresh(),
      child: ListView.builder(
        itemCount: complaints.length,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05)
            .add(const EdgeInsets.only(bottom: 30)),
        itemBuilder: (context, index) {
          final cubit = ComplainsCubit.of(context);
          final item = complaints[index];
          final itemWidget = ComplaintItem(item);
          final isLast = complaints.length == index + 1;

          if (isLast && cubit.canLoadMore && !isLodingMore) {
            cubit.loadMore();
          }
          if (isLast && isLodingMore) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                itemWidget,
                const CenterLoading(),
              ],
            );
          } else {
            return itemWidget;
          }
        },
      ),
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
