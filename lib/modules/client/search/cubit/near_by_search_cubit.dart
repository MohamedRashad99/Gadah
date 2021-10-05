import 'package:bloc/bloc.dart';
import 'package:gadha/comman/models/responses/places.dart';
import 'package:gadha/comman/services/places_service.dart';
import 'package:meta/meta.dart';

part 'near_by_search_state.dart';

class NearBySearchCubit extends Cubit<NearBySearchState> {
  final String? type;
  final String? name;
  NearBySearchCubit({this.type, this.name}) : super(NearBySearchLoading()) {
    refresh();
  }
  String _keyword = '';
  int _pageNo = 0;
  bool _canLoadMore = true;
  bool get canLoadMore => _canLoadMore;
  double _searchRaduis = 1500;
  final _places = <PlaceEntity>[];
  // PlacesResponse? _lastResp;

  double get searchReadius => _searchRaduis;
  final _service = PlacesService();
  void onRadiusChange(double radius) {
    _searchRaduis = radius;
    refresh();
  }

  void onKeywordChange(String msg) {
    _keyword = msg.trim();
    refresh();
  }

  Future<void> refresh() async {
    _pageNo = 0;
    _places.clear();
    _canLoadMore = true;
    await loadMore();
  }

  Future<void> loadMore() async {
    if (!_canLoadMore) return;
    try {
      emit(_pageNo == 0
          ? NearBySearchLoading()
          : NearBySearchLoadedMore(_places));
      final data = await _service.findPlaces(
        keyword: _keyword,
        type: type,
        name: name,
      );
      _canLoadMore = data.results?.isNotEmpty ?? false;
      _places.addAll(data.results ?? []);
      emitPlaces();
    } catch (e) {
      emit(NearBySearchCant(e.toString()));
    }
  }

  void emitPlaces() {
    if (_places.isEmpty) {
      emit(NearBySearchEmpty());
    } else {
      emit(NearBySearchLoaded(_places));
    }
  }
}
