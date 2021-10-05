import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/comman/services/orders_repo.dart';
import 'package:meta/meta.dart';
import 'package:queen/queen.dart';

part 'orders_in_progress_state.dart';

class OrdersInProgressCubit extends Cubit<OrdersInProgressState> {
  OrdersInProgressCubit() : super(OrdersInProgressLoading()) {
    refresh();
  }
  factory OrdersInProgressCubit.of(BuildContext context) =>
      BlocProvider.of<OrdersInProgressCubit>(context, listen: false);

  final _orders = <OrderEntity>[];
  final _ordersRepo = OrdersRepo();

  Future<void> refresh() async {
    _pageNo = 0;
    _canLoadMore = true;
    _orders.clear();
    return loadMore();
  }

  int _pageNo = 0;
  bool _canLoadMore = true;
  bool get canLoadMore => _canLoadMore;

  Future<void> loadMore() async {
    if (!_canLoadMore) return;
    try {
      emit(_pageNo == 0
          ? OrdersInProgressLoading()
          : OrdersInProgressLoadingMore(_orders));
      final _newOrders = await _ordersRepo.findOrdersInProgress(++_pageNo);
      _canLoadMore = _newOrders.isNotEmpty;
      _orders.addAll(_newOrders);
      emit(_orders.isEmpty
          ? OrdersInProgressEmpty()
          : OrdersInProgressLoaded(_orders));
    } catch (e, st) {
      log(st.toString());
      emit(OrdersInProgressError(e.toString()));
    }
  }
}
