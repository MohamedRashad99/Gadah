import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gadha/modules/client/make_order/models/order_item_to_add.dart';
import 'package:meta/meta.dart';
import 'package:queen/queen.dart';

part 'order_items_state.dart';

class OrderItemsCubit extends Cubit<OrderItemsState> {
  OrderItemsCubit() : super(OrderItemsLoaded(const []));
  factory OrderItemsCubit.of(BuildContext context) =>
      BlocProvider.of<OrderItemsCubit>(
        context,
        listen: false,
      );
  final _items = <OrderItemToAdd>[];
  List<OrderItemToAdd> get items => _items;

  void refresh() => emit(OrderItemsLoaded(items));
  void addItem() {
    _items.add(const OrderItemToAdd(name: ''));
    refresh();
  }

  Future<void> updateAt(int index, OrderItemToAdd item) async {
    _items[index] = item;
    refresh();
  }

  Future<void> deleteAt(int index) async {
    _items.removeAt(index);
    refresh();
  }

  Future<void> clear(int index) async {
    _items.clear();
    refresh();
  }
}
