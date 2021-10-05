import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/comman/services/auth_service.dart';
import 'package:gadha/modules/shared/order_bills/models/bill.dart';
import 'package:gadha/widgets/signle/center_error.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:gadha/widgets/signle/app_bar.dart';

import 'package:shimmer/shimmer.dart';

import 'create_one_dialog.dart';
import 'cubit/order_bills_cubit.dart';
import 'delete_one_dialog.dart';
import 'item.dart';

class OrderBillsPage extends StatefulWidget {
  final OrderEntity orderEntity;

  const OrderBillsPage({Key? key, required this.orderEntity}) : super(key: key);
  @override
  _OrderBillsPageState createState() => _OrderBillsPageState();
}

class _OrderBillsPageState extends State<OrderBillsPage> {
  @override
  Widget build(_) {
    /// only driver can add bills to order

    return BlocProvider(
      create: (_) => OrderBillsCubit(widget.orderEntity.id),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: const StanderedAppBar(),
          floatingActionButton: AuthService.currentUser!.isDriver
              ? FloatingActionButton(
                  onPressed: () => Q.dialog(CreateBillDialog(
                      orderEntity: widget.orderEntity,
                      cubit: OrderBillsCubit.of(context))),
                  child: const Icon(Icons.add, color: Colors.white),
                )
              : null,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                StanderedAppBar(
                  appBarType: AppBarType.navigatorExtended,
                  centerChild: Text(
                    'bills'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<OrderBillsCubit, OrderBillsState>(
                    builder: (context, state) {
                      if (state is OrderBillsLoading) {
                        return ListView.builder(
                          itemCount: 10,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05, vertical: 20),
                          itemBuilder: (_, i) => _buildLoading(size),
                        );
                      } else if (state is OrderBillsEmpty) {
                        return CenterError(
                          icon: FontAwesomeIcons.smileBeam,
                          message: 'no_order_Bills'.tr,
                        );
                      } else if (state is OrderBillsLoaded) {
                        return buidContent(state.bills);
                      } else if (state is OrderBillsCatLoad) {
                        return CenterError(
                          icon: FontAwesomeIcons.moneyBillWave,
                          message: state.msg,
                          /*buttomText: 'refresh'.tr,
                          onReload: OrderBillsCubit.of(context).refresh,*/
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buidContent(List<OrderBill> bills) {
    return RefreshIndicator(
      onRefresh: () async => OrderBillsCubit.of(context).refresh(),
      child: ListView.builder(
        itemCount: bills.length,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05)
            .add(const EdgeInsets.only(bottom: 30)),
        itemBuilder: (context, index) => BillItem(
            bills[index], index + 1, () => deleteOne(context, bills[index])),
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

  void deleteOne(BuildContext context, OrderBill bill) => Q.dialog(
        DeleteBillDialog(
          orderEntity: widget.orderEntity,
          orderBill: bill,
          cubit: OrderBillsCubit.of(context),
        ),
      );
}
