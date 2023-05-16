part of 'menu_cubit.dart';

@immutable
abstract class MenuState {}

class MenuInitial extends MenuState {}
class AllCategoryLoading extends MenuState {}
class AllCategoryError extends MenuState {}
class AllCategoryLoaded extends MenuState {
  final List<CategoryModel> categoryList;

  AllCategoryLoaded(this.categoryList);

}
class AllProductLoading extends MenuState {}
class AllProductError extends MenuState {}
class AllProductLoaded extends MenuState {
  final List<ProductItemModel> productList;
  AllProductLoaded(this.productList);
}

class ChangeItemCount extends MenuState {}


class AllProductSearchLoading extends MenuState {}
class AllProductSearchLoaded extends MenuState {}
class AllProductSearchError extends MenuState {}
