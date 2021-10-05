part of 'order_items_cubit.dart';

@immutable
abstract class OrderItemsState extends Equatable {}

class OrderItemsLoaded extends OrderItemsState {
  final List<OrderItemToAdd> items;
  OrderItemsLoaded(this.items);

  @override
  List<Object?> get props => [UniqueKey()];
}
