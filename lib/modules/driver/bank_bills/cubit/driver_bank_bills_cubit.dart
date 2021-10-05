import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gadha/modules/driver/bank_bills/data/service.dart';
import 'package:gadha/modules/driver/bank_bills/models/bank_bill.dart';
import 'package:meta/meta.dart';
import 'package:queen/queen.dart';

part 'driver_bank_bills_state.dart';

class DriverBankBillsCubit extends Cubit<DriverBankBillsState> {
  DriverBankBillsCubit() : super(DriverBankBillsLoading()) {
    refresh();
  }
  factory DriverBankBillsCubit.of(BuildContext context) =>
      BlocProvider.of<DriverBankBillsCubit>(context);

  final _billsService = BankBillsService();
  final _bills = <BankBill>[];
  var _canLoadMore = true;
  bool get canLoadMore => _canLoadMore;
  var _pageNo = 0;

  void refresh() {
    _bills.clear();
    _canLoadMore = true;
    _pageNo = 0;
    loadMore();
  }

  Future<void> loadMore() async {
    if (!_canLoadMore) return;
    emit(_bills.isEmpty
        ? DriverBankBillsLoading()
        : DriverBankBillsMore(_bills));
    try {
      final newBills = await _billsService.findMany(++_pageNo);
      if (newBills.isEmpty) {
        _canLoadMore = false;
      }
      _bills.addAll(newBills);
      if (_bills.isEmpty) {
        emit(DriverBankBillsEmpty());
      } else {
        emit(DriverBankBillsLoaded(_bills));
      }
    } catch (e) {
      emit(DriverBankBillsCatLoad(e.toString()));
    }
  }
}
