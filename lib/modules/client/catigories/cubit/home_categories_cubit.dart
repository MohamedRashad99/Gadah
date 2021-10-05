import 'package:bloc/bloc.dart';
import 'package:gadha/modules/client/catigories/models/category.dart';
import 'package:gadha/modules/client/catigories/data/catigories_service.dart';
import 'package:meta/meta.dart';
import 'package:queen/queen.dart';

part 'home_categories_state.dart';

class HomeCategoriesCubit extends Cubit<HomeCategoriesState> {
  HomeCategoriesCubit() : super(HomeCategoriesLoading()) {
    refresh();
  }
  // int _page = 1;
  List<CategoryModel> data = [];
  // bool canLoadMore = true;
  Future<void> refresh() async {
    // _page = 1;
    data.clear();
    // canLoadMore = true;
    emit(HomeCategoriesLoading());
    // await Future.delayed(const Duration(seconds: 5));
    try {
      // throw 'cant load cats';

      final res = await CatigoriesService.findMany();
      data.addAll(res);
      emit(HomeCategoriesLoaded(data));
    } catch (e) {
      emit(HomeCategoriesCant(e.toString()));
    }
  }

  // Future<void> loadMore() async {
  //   emit(HomeCategoriesLoadingMore(data));
  //   try {
  //     final res = await service.findManyByPage(pageNumber: ++_page);
  //     if (data.isEmpty) {
  //       canLoadMore = false;
  //     } else {
  //       data.addAll(res);
  //     }
  //     emit(HomeCategoriesLoaded(data));
  //   } on  LaravelException.parse catch (e) {
  //     emit(HomeCategoriesCant(e.fullErrorMessage));
  //   } catch (e) {
  //     emit(HomeCategoriesCant(e.toString()));
  //   }
  // }
}
