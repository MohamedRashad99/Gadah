import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/comman/services/orders_repo.dart';
import 'package:meta/meta.dart';
import 'package:queen/queen.dart';

part 'user_offers_state.dart';

class UserOrdersCubit extends Cubit<UserOrdersState> {
  final _ordersRepo = OrdersRepo();
  UserOrdersCubit() : super(UserOrdersInitial()) {
    loadMore();
  }

  factory UserOrdersCubit.of(BuildContext context) {
    return BlocProvider.of(context, listen: false);
  }
  final _offers = <OrderEntity>[];

  Future<void> refresh() async {
    _offers.clear();
    return loadMore();
  }

  Future<void> loadMore() async {
    try {
      emit(UserOrdersLoading());
      _offers.addAll(await _ordersRepo.findUserOrders());
      emit(_offers.isEmpty ? UserOrdersIsEmpty() : UserOrdersLoaded(_offers));
    } catch (e, st) {
      log(e.toString());
      log(st.toString());
      emit(UserOrdersError(msg: e.toString()));
    }
  }
}
