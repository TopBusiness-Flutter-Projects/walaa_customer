import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/models/login_model.dart';
import '../../../core/models/order_model.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/remote/service.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  List<OrderModel> neworderList = [];
  List<OrderModel> oldorderList = [];
  late int odersize = 0;
  late int odersize1 = 0;
  final ServiceApi serviceApi;

  late LoginModel userModel;
  late String lang;

  OrderCubit(this.serviceApi) : super(OrderInitial()) {
    getUserData().then((value) => getorders(value));
  }

  setlang(String lang) {
    this.lang = lang;
  }

  Future<LoginModel?> getUserData() async {
    userModel = await Preferences.instance.getUserModel();
    return userModel;
  }


  int currentIndex = 0;

  selectTap(int index) {
    currentIndex = index;
    emit(OrderChangeCurrentIndexTap());
  }

  getorders(LoginModel? usermodel) async {
    odersize = 1;
    odersize1 = 1;
    emit(AllOrderLoading());
    final response = await serviceApi.getOrders(usermodel!.data!.accessToken!, lang);
    response.fold(

            (l) => {
          print(l)
        },
    (r) async {
    if (r.code == 200) {
      print(r.data);
      odersize=r.data!.dataNew!.length;
      odersize1=r.data!.accepted!.length;
      neworderList = r.data!.dataNew!;
      oldorderList = r.data!.accepted!;
      emit(AllOrderLoaded(neworderList));
    } else {
     // print(response.status.message);
      emit(AllOrderError());
    }
  });}
}
