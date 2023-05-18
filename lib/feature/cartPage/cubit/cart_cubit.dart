import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:walaa_customer/core/remote/service.dart';
import 'package:walaa_customer/core/utils/app_colors.dart';
import 'package:walaa_customer/core/utils/appwidget.dart';
import 'package:walaa_customer/core/utils/toast_message_method.dart';

import '../../../../core/preferences/preferences.dart';
import '../../../core/models/cart_model.dart';
import '../../../core/models/login_model.dart';
import '../../../core/models/status_resspons.dart';
import '../../navigation_bottom/cubit/navigator_bottom_cubit.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final ServiceApi serviceApi;

  late LoginModel userModel;

  CartCubit(this.serviceApi) : super(CartInitial()) {
    getUserData();
    getTotalPrice();
  }
  @override
  Future<void> close() {
    //subscription.cancel();
    return super.close();
  }
  Future<LoginModel?> getUserData() async {
    userModel = await Preferences.instance.getUserModel();
    return userModel;
  }

  CartModel? cartModel;
  int itemCount = 1;
  int itemPrice = 1;
  double totalPrice = 0;

  getTotalPrice() async {
    cartModel = await Preferences.instance.getCart();

    totalPrice = cartModel!.totalPrice!;
    emit(GetTotalPrice());
  }

  changeItemCount(String type, int price) {
    if (type == '+') {
      itemCount++;
      itemPrice = itemPrice + price;
      print(itemPrice);
      emit(CartChangeItemCount());
    } else {
      if (itemCount > 1) {
        itemCount--;
        itemPrice = itemPrice - price;
        print(itemPrice);
        emit(CartChangeItemCount());
      }
    }
  }


  sendorder(CartModel model, BuildContext context) async {

    AppWidget.createProgressDialog(context, 'wait');
//model.phone=userModel.data!.user.phone;

    try {
      final response =
          await serviceApi.sendOrder(model, userModel.data!.accessToken);
      print(response);
      response.fold(

              (l) => {
                print(l)
              },
              (r) async {
                print(r);
      if (r.code == 200) {

        toastMessage("sucess", AppColors.primary);
        Preferences.instance.clearCartData(context);

        //context.read<OrderCubit>().setlang(lang);
        //context.read<OrderCubit>().getorders(userModel);
        context.read<NavigatorBottomCubit>().changePage(0);
        Navigator.pop(context);


       // Navigator.pop(context);


        // Fluttertoast.showToast(msg: 'deleted'.tr(),fontSize: 15.0,backgroundColor: AppColors.black,gravity: ToastGravity.SNACKBAR,textColor: AppColors.white);

        // emit(AllProductLoaded(productList));
      } else {
    toastMessage(r.message, AppColors.primary);
    Navigator.pop(context);
    // productList[index] = model;
    //emit(AllCategoryLoaded(categoryList));
    }});
    } catch (e) {
      print("Dldldldl${e.toString()}");
      //  Future.delayed(Duration(seconds: 1)).then((value) => emit(OnError(e.toString())));
    }
  }
}
