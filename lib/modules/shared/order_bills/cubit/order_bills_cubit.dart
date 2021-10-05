import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gadha/modules/shared/order_bills/models/bill.dart';
import 'package:meta/meta.dart';
import 'package:queen/queen.dart';
import '../data/bills_service.dart' as service;
part 'order_bills_state.dart';

class OrderBillsCubit extends Cubit<OrderBillsState> {
  final int orderId;
  OrderBillsCubit(this.orderId) : super(OrderBillsLoading()) {
    refresh();
  }
  factory OrderBillsCubit.of(BuildContext context) =>
      BlocProvider.of<OrderBillsCubit>(context);

  final _orderBills = <OrderBill>[];

  Future<void> refresh() async {
    emit(OrderBillsLoading());
    try {
      _orderBills.clear();
      final newBills = await service.findMany(orderId);

      _orderBills.addAll(newBills);
      if (_orderBills.isEmpty) {
        emit(OrderBillsEmpty());
      } else {
        emit(OrderBillsLoaded(_orderBills));
      }
    } catch (e) {
      emit(OrderBillsCatLoad(e.toString()));
    }
  }
}
