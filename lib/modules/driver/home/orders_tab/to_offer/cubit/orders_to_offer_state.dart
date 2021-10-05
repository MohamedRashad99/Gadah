part of 'orders_to_offer_cubit.dart';

@immutable
abstract class OrdersToOfferState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrdersToOfferLoading extends OrdersToOfferState {}

class OrdersToOfferEmpty extends OrdersToOfferState {}

class OrdersToOfferLoadingMore extends OrdersToOfferState {
  final List<OrderEntity> orders;
  OrdersToOfferLoadingMore(this.orders);
}

class OrdersToOfferLoaded extends OrdersToOfferState {
  final List<OrderEntity> orders;

  OrdersToOfferLoaded(this.orders);
}

class OrdersToOfferError extends OrdersToOfferState {
  final String msg;

  OrdersToOfferError(this.msg);
}
