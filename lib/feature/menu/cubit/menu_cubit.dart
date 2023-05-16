import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/remote/service.dart';
import '../../home page/models/providers_model.dart';
import '../models/product_data_model.dart';
import '../models/product_model.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit(this.serviceApi) : super(MenuInitial());
  final ServiceApi serviceApi;

  List<ProductItemModel> productList = [];
  List<ProductItemModel> bestProductList = [];
  List<ProductItemModel> searchProductList = [];
  int productLength = 0;
  int itemCount = 1;
  int itemPrice = 1;
  int selectItem = 0;
  CategoryModel? categoryModel;
  changeItemCount(String type,int price) {
    if (type == '+') {
      itemCount++;
      itemPrice = (itemPrice + price) ;
      print(itemPrice);
      emit(ChangeItemCount());
    } else {
      if (itemCount > 1) {
        itemCount--;
        itemPrice = (itemPrice  - price) ;
        print(itemPrice);
        emit(ChangeItemCount());
      }
    }
  }
  getProduct(int category_id) async {
    productLength = 1;
    emit(AllProductLoading());
    final response = await serviceApi.getProduct(category_id);
    response.fold((l) => emit(AllProductError()), (r) async {
      if (r.code == 200) {
        // productLength = r.data!.products!.length;
        productList = r.data!.products!;
        bestProductList = r.data!.theBest!;
        emit(AllProductLoaded(productList));
      } else {
        print(r.message);
        emit(AllProductError());
      }
    });
  }

  searchProduct(int provider_id, String text) async {
    if (text.length > 0) {
      searchProductList.clear();
      emit(AllProductSearchLoading());
      final response = await serviceApi.searchProduct(provider_id, text);
      response.fold(
        (l) => emit(AllProductSearchError()),
        (r) async {
          if (r.code == 200) {
            searchProductList = r.data!;
            emit(AllProductSearchLoaded());
          } else {
            print(r.message);
            emit(AllProductSearchError());
          }
        },
      );
    }
  }
}
