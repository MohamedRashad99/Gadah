part of 'driver_bank_bills_cubit.dart';

@immutable
abstract class DriverBankBillsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DriverBankBillsLoading extends DriverBankBillsState {}

class DriverBankBillsEmpty extends DriverBankBillsState {}

class DriverBankBillsMore extends DriverBankBillsState {
  final List<BankBill> bills;

  DriverBankBillsMore(this.bills);
  @override
  List<Object?> get props => [bills];
}

class DriverBankBillsLoaded extends DriverBankBillsState {
  final List<BankBill> bills;

  DriverBankBillsLoaded(this.bills);
  @override
  List<Object?> get props => [bills];
}

class DriverBankBillsCatLoad extends DriverBankBillsState {
  final String msg;
  DriverBankBillsCatLoad(this.msg);
  @override
  List<Object?> get props => [msg];
}
