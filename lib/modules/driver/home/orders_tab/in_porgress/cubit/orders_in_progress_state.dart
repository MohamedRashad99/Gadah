part of 'orders_in_progress_cubit.dart';

@immutable
abstract class OrdersInProgressState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrdersInProgressLoading extends OrdersInProgressState {}

class OrdersInProgressEmpty extends OrdersInProgressState {}

class OrdersInProgressLoadingMore extends OrdersInProgressState {
  final List<OrderEntity> orders;
  OrdersInProgressLoadingMore(this.orders);
}

class OrdersInProgressLoaded extends OrdersInProgressState {
  final List<OrderEntity> orders;

  OrdersInProgressLoaded(this.orders);
}

class OrdersInProgressError extends OrdersInProgressState {
  final String msg;

  OrdersInProgressError(this.msg);
}
