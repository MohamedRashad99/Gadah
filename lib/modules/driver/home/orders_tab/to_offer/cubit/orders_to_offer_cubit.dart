import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/comman/services/orders_repo.dart';
import 'package:meta/meta.dart';
import 'package:queen/queen.dart';

part 'orders_to_offer_state.dart';

class OrdersToOfferCubit extends Cubit<OrdersToOfferState> {
  OrdersToOfferCubit() : super(OrdersToOfferLoading()) {
    refresh();
  }

  factory OrdersToOfferCubit.of(BuildContext context) =>
      BlocProvider.of<OrdersToOfferCubit>(context, listen: false);

  final _orders = <OrderEntity>[];
  final _ordersRepo = OrdersRepo();
  int _pageNo = 0;
  bool _canLoadMore = true;
  bool get canLoadMore => _canLoadMore;

  Future<void> refresh() async {
    _pageNo = 0;
    _canLoadMore = true;
    _orders.clear();
    return loadMore();
  }

  Future<void> loadMore() async {
    if (!_canLoadMore) return;
    try {
      emit(_pageNo == 0
          ? OrdersToOfferLoading()
          : OrdersToOfferLoadingMore(_orders));
      final _newOrders = await _ordersRepo.findOrdersToAccept(++_pageNo);
      _canLoadMore = _newOrders.isNotEmpty;
      _orders.addAll(_newOrders);
      emit(_orders.isEmpty
          ? OrdersToOfferEmpty()
          : OrdersToOfferLoaded(_orders));
    } catch (e, st) {
      log(st.toString());
      emit(OrdersToOfferError(e.toString()));
    }
  }
}
