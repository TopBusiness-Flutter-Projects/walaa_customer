import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/menu/models/product_data_model.dart';
import '../../feature/menu/models/product_model.dart';
import '../../feature/navigation_bottom/cubit/navigator_bottom_cubit.dart';
import '../models/cart_model.dart';
import '../models/login_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import '../utils/toast_message_method.dart';

class Preferences {


  static final Preferences instance = Preferences._internal();

  Preferences._internal();

  factory Preferences() => instance;
  Future<void> setFirstInstall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('onBoarding', 'Done');
  }

  Future<String?> getFirstInstall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('onBoarding');
    return jsonData;
  }

  Future<void> setUser(LoginModel loginModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(
        'user', jsonEncode(LoginModel.fromJson(loginModel.toJson())));
    print(await getUserModel());
  }

  Future<LoginModel> getUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonData = preferences.getString('user');
    LoginModel userModel;
    if (jsonData != null) {
      userModel = LoginModel.fromJson(jsonDecode(jsonData));
      userModel.data!.user.isLoggedIn = true;
    } else {
      userModel = LoginModel();
    }
    return userModel;
  }

  Future<bool> clearUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove('user');
  }

  Future<String> getSavedLang() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(AppStrings.locale) ?? 'ar';
  }
  addItemToCart(ProductItemModel model, int qty,String phone,BuildContext context) async {
    CartModel cartModel = await getCart();
    bool isNew = true;
    cartModel.orderDetails!.forEach(
          (element) {
        if (element.productId == model.id&&cartModel.phone==phone) {
          int index = cartModel.orderDetails!.indexOf(element);
          cartModel.orderDetails![index].qty =
              cartModel.orderDetails![index].qty + qty;
          cartModel.productModel![index].quantity =
              cartModel.productModel![index].quantity + qty;
          cartModel.totalPrice = (cartModel.totalPrice! +
              (qty * (cartModel.productModel![index].priceAfterDiscount==0?cartModel.productModel![index].price!:cartModel.productModel![index].priceAfterDiscount!)));
          setCart(cartModel,context);
          isNew = false;
        }
      },
    );
    if (isNew) {
      if(cartModel.productModel!.isEmpty||(cartModel.phone==phone)){
      model.quantity = qty;
      cartModel.phone=phone;
      cartModel.totalPrice = (cartModel.totalPrice! + (qty * (model.priceAfterDiscount==0?model.price!:model.priceAfterDiscount!)));
      cartModel.productModel!.add(model);
      cartModel.orderDetails!.add(
        OrderDetails(
          productId: model.id!,
          qty: model.quantity,
        ),
      );
      setCart(cartModel,context);

    }
}
  }

  changeProductCount(ProductItemModel model, int qty, int price,context) async {
    CartModel cartModel = await getCart();
    cartModel.productModel!.forEach(
          (element) {
        if (element.id == model.id) {
          int index = cartModel.productModel!.indexOf(element);
          cartModel.orderDetails![index].qty = qty;
          cartModel.productModel![index].quantity = qty;
          cartModel.totalPrice = cartModel.totalPrice! + price;
          setCart(cartModel,context);
        }
      },
    );
  }

  deleteProduct(ProductItemModel model,BuildContext context) async {
    CartModel cartModel = await getCart();
    for (int i = 0; i <= cartModel.productModel!.length; i++) {
      if (cartModel.productModel![i].id == model.id) {
        cartModel.orderDetails!.removeAt(i);
        cartModel.productModel!.removeAt(i);
        cartModel.totalPrice =
            cartModel.totalPrice! - ((model.priceAfterDiscount==0?model.price!:model.priceAfterDiscount!) * model.quantity);
        setCart(cartModel,context);
        break;
      }
    }
  }
  Future<void> setCart(CartModel cartModel,BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('cart', jsonEncode(CartModel.toJson(cartModel)));
    context.read<NavigatorBottomCubit>().getCartSize();
  }
  clearCartData(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('cart');
    context.read<NavigatorBottomCubit>().getCartSize();

  }

  Future<CartModel> getCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonData = preferences.getString('cart');
    CartModel cartModel;
    if (jsonData != null) {
      cartModel = CartModel.fromJson(jsonDecode(jsonData));
    } else {
      cartModel = CartModel(
        orderDetails: [],
        productModel: [],
        phone: '',
        note: '',
        totalPrice: 0,
      );
    }
    return cartModel;
  }

}
