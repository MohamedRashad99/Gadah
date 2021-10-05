part of 'order_bills_cubit.dart';

@immutable
abstract class OrderBillsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderBillsLoading extends OrderBillsState {}

class OrderBillsEmpty extends OrderBillsState {}

class OrderBillsLoaded extends OrderBillsState {
  final List<OrderBill> bills;

  OrderBillsLoaded(this.bills);
  @override
  List<Object?> get props => [bills];
}

class OrderBillsCatLoad extends OrderBillsState {
  final String msg;
  OrderBillsCatLoad(this.msg);
  @override
  List<Object?> get props => [msg];
}
