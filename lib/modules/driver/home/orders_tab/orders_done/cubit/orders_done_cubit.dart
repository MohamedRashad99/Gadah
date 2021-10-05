import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/comman/services/orders_repo.dart';
import 'package:meta/meta.dart';
import 'package:queen/queen.dart';

part 'orders_done_state.dart';

class OrdersDoneCubit extends Cubit<OrdersDoneState> {
  OrdersDoneCubit() : super(OrdersDoneLoading()) {
    refresh();
  }

  factory OrdersDoneCubit.of(BuildContext context) =>
      BlocProvider.of<OrdersDoneCubit>(context, listen: false);

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
      emit(_pageNo == 0 ? OrdersDoneLoading() : OrdersDoneLoadingMore(_orders));
      final _newOrders =
          await _ordersRepo.findOrdersDriverDoneOrders(++_pageNo);
      _canLoadMore = _newOrders.isNotEmpty;
      _orders.addAll(_newOrders);
      emit(_orders.isEmpty ? OrdersDoneEmpty() : OrdersDoneLoaded(_orders));
    } catch (e, st) {
      log(st.toString());
      emit(OrdersDoneError(e.toString()));
    }
  }
}
