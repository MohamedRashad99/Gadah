part of 'user_offers_cubit.dart';

@immutable
abstract class UserOrdersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserOrdersInitial extends UserOrdersState {}

class UserOrdersIsEmpty extends UserOrdersState {}

class UserOrdersLoaded extends UserOrdersState {
  final List<OrderEntity> orders;

  UserOrdersLoaded(
    this.orders,
  );

  @override
  List<Object?> get props => [orders];
}

class UserOrdersError extends UserOrdersState {
  final String msg;
  UserOrdersError({required this.msg});
  @override
  List<Object?> get props => [msg];
}

class UserOrdersLoading extends UserOrdersState {}
