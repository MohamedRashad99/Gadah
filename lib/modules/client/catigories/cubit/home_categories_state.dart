part of 'home_categories_cubit.dart';

@immutable
abstract class HomeCategoriesState {}

class HomeCategoriesLoading extends HomeCategoriesState {}

class HomeCategoriesLoadingMore extends HomeCategoriesState {
  final List<CategoryModel> catigores;

  HomeCategoriesLoadingMore(this.catigores);
}

class HomeCategoriesLoaded extends HomeCategoriesState {
  final List<CategoryModel> catigores;

  HomeCategoriesLoaded(this.catigores);
}

class HomeCategoriesCant extends HomeCategoriesState {
  final String msg;

  HomeCategoriesCant(this.msg);
}
