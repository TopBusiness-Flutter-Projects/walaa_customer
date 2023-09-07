// import 'package:easy_localization/easy_localization.dart';

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/models/cart_model.dart';
import 'package:walaa_customer/core/remote/service.dart';

import '../../../core/preferences/preferences.dart';



part 'navigator_bottom_state.dart';

class NavigatorBottomCubit extends Cubit<NavigatorBottomState> {
  NavigatorBottomCubit(this.api) : super(NavigatorBottomInitial()){
    onUserDataSuccess();
  }
  final ServiceApi api;
  int page = 0;
  String title='home';
  String lan ='ff';

  String size='0';
String softwareType='';
  onUserDataSuccess() async {
   // user = await Preferences.instance.getUserModel().whenComplete(() => null);
    getCartSize();
    Preferences.instance.getUserModel().then((value) => {if(value.data!=null){
    getDeviceToken()
    }
    });
  }

  changePage(int index) {
    page = index;
    // this.title=title;
    emit(NavigatorBottomChangePage());
  }
  getCartSize() async {
    CartModel cartModel=await Preferences.instance.getCart();
    size=cartModel.productModel!.length.toString();
    emit(NavigatorBottomInitial());

  }
  getDeviceToken()async{
    String? token=await FirebaseMessaging.instance.getToken();
    if(Platform.isAndroid){
      softwareType="android";
    }
    else {
      softwareType="ios";
    }
    final response=await api.addDeviceToken(token!, softwareType);
    response.fold((l) => {}, (r) => {

    });
  }
}
