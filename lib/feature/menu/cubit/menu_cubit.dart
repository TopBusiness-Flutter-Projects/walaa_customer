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

  // changeItemCount(String type, int price) {
  //   if (type == '+') {
  //     itemCount++;
  //     itemPrice = (itemPrice + price);
  //     print(itemPrice);
  //     emit(ChangeItemCount());
  //   } else {
  //     if (itemCount > 1) {
  //       itemCount--;
  //       itemPrice = (itemPrice - price);
  //       print(itemPrice);
  //       emit(ChangeItemCount());
  //     }
  //   }
  // }

  // getCategory() async {
  //   categoryLength = 1;
  //   emit(AllCategoryLoading());
  //   final response = await serviceApi.getCategory();
  //   response.fold((l) => emit(AllCategoryError()), (r) {
  //     if (r.status.code == 200) {
  //       print(r.data);
  //       categoryLength = r.data.length;
  //       categoryList = r.data;
  //       emit(AllCategoryLoaded(categoryList));
  //       if (categoryList.length > 0) {
  //         getProduct(categoryList.elementAt(0).id!);
  //       }
  //     } else {
  //       print(r.status.message);
  //       emit(AllCategoryError());
  //     }
  //   });
  // }

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
