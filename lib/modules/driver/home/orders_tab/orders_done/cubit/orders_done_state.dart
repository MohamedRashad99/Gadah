part of 'orders_done_cubit.dart';

@immutable
abstract class OrdersDoneState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrdersDoneLoading extends OrdersDoneState {}

class OrdersDoneEmpty extends OrdersDoneState {}

class OrdersDoneLoadingMore extends OrdersDoneState {
  final List<OrderEntity> orders;
  OrdersDoneLoadingMore(this.orders);
}

class OrdersDoneLoaded extends OrdersDoneState {
  final List<OrderEntity> orders;

  OrdersDoneLoaded(this.orders);
}

class OrdersDoneError extends OrdersDoneState {
  final String msg;

  OrdersDoneError(this.msg);
}
