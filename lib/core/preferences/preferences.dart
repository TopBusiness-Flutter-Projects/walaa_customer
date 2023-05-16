import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/menu/models/product_data_model.dart';
import '../../feature/menu/models/product_model.dart';
import '../models/cart_model.dart';
import '../models/login_model.dart';
import '../utils/app_strings.dart';

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
  addItemToCart(ProductItemModel model, int qty) async {
    CartModel cartModel = await getCart();
    bool isNew = true;
    cartModel.orderDetails!.forEach(
          (element) {
        if (element.productId == model.id) {
          int index = cartModel.orderDetails!.indexOf(element);
          cartModel.orderDetails![index].qty =
              cartModel.orderDetails![index].qty + qty;
          cartModel.productModel![index].quantity =
              cartModel.productModel![index].quantity + qty;
          cartModel.totalPrice = (cartModel.totalPrice! +
              (qty * (cartModel.productModel![index].priceAfterDiscount==0?cartModel.productModel![index].price!:cartModel.productModel![index].priceAfterDiscount!)));
          setCart(cartModel);
          isNew = false;
        }
      },
    );
    if (isNew) {
      model.quantity = qty;
      cartModel.totalPrice = (cartModel.totalPrice! + (qty * (model.priceAfterDiscount==0?model.price!:model.priceAfterDiscount!)));
      cartModel.productModel!.add(model);
      cartModel.orderDetails!.add(
        OrderDetails(
          productId: model.id!,
          qty: model.quantity,
        ),
      );
      setCart(cartModel);
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
          setCart(cartModel);
        }
      },
    );
  }

  deleteProduct(ProductItemModel model) async {
    CartModel cartModel = await getCart();
    for (int i = 0; i <= cartModel.productModel!.length; i++) {
      if (cartModel.productModel![i].id == model.id) {
        cartModel.orderDetails!.removeAt(i);
        cartModel.productModel!.removeAt(i);
        cartModel.totalPrice =
            cartModel.totalPrice! - ((model.priceAfterDiscount==0?model.price!:model.priceAfterDiscount!) * model.quantity);
        setCart(cartModel);
        break;
      }
    }
  }
  Future<void> setCart(CartModel cartModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('cart', jsonEncode(CartModel.toJson(cartModel)));
  }
  clearCartData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('cart');
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
