import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/remote/service.dart';
import '../../home page/models/providers_model.dart';
import '../models/product_model.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit(this.serviceApi) : super(MenuInitial());
  final ServiceApi serviceApi;

  List<ProductModel> productList = [];
  int productLength = 0;
  int itemCount = 1;
  int itemPrice = 1;
  CategoryModel? categoryModel;

  getProduct(int category_id) async {
    productLength = 1;
    emit(AllProductLoading());
    final response = await serviceApi.getProduct(category_id);
    response.fold((l) => emit(AllProductError()), (r) async {
      if (r.status.code == 200) {
        print(r.data);
        productLength = r.data.length;
        productList = r.data;
        emit(AllProductLoaded(productList));
      } else {
        print(r.status.message);
        emit(AllProductError());
      }
    });
  }
}
