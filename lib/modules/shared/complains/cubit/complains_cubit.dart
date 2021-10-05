import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gadha/modules/shared/complains/models/complain.dart';
import 'package:gadha/comman/services/complaints_service.dart';
import 'package:meta/meta.dart';
import 'package:queen/queen.dart';

part 'complains_state.dart';

class ComplainsCubit extends Cubit<ComplainsState> {
  ComplainsCubit() : super(ComplainsLoading()) {
    refresh();
  }
  factory ComplainsCubit.of(BuildContext context) =>
      BlocProvider.of<ComplainsCubit>(context);

  final _complainsService = ComplaintsService();
  final _complains = <ComplianEntity>[];
  var _canLoadMore = true;
  bool get canLoadMore => _canLoadMore;
  var _pageNo = 0;

  void refresh() {
    _complains.clear();
    _canLoadMore = true;
    _pageNo = 0;
    loadMore();
  }

  Future<void> loadMore() async {
    if (!_canLoadMore) return;
    emit(_complains.isEmpty
        ? ComplainsLoading()
        : ComplainsLoadingMore(_complains));
    try {
      final newComplaiins = await _complainsService.findMany(++_pageNo);
      if (newComplaiins.isEmpty) {
        _canLoadMore = false;
      }
      _complains.addAll(newComplaiins);
      if (_complains.isEmpty) {
        emit(ComplainsEmpty());
      } else {
        emit(ComplainsLoaded(_complains));
      }
    } catch (e) {
      emit(ComplainsCatLoad(e.toString()));
    }
  }
}
