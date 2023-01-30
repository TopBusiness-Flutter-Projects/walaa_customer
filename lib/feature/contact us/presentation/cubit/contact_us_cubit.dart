import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaa_customer/core/models/login_model.dart';
import 'package:walaa_customer/core/remote/service.dart';

import '../../models/contact_us_model.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit(this.api) : super(ContactUsInitial()) {
    _getStoreUser();
  }

  final ServiceApi api;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  LoginModel? loginModel;

  Future<void> _getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
      LoginModel loginModel = LoginModel.fromJson(userMap);
      this.loginModel = loginModel;
      nameController.text = this.loginModel!.data!.user.name!;
      phoneController.text = this.loginModel!.data!.user.phone!;
      emit(ContactUsGetUserModel());
    }
  }

  contactUsApi() async {
    emit(ContactUsLoading());
    final response = await api.contactUsApi(
      ContactUsData(
        name: nameController.text,
        phone: phoneController.text,
        subject: subjectController.text,
        message: messageController.text,
      ),
    );
    response.fold(
      (l) => emit(ContactUsError()),
      (r) {
        emit(ContactUsLoaded());
        Future.delayed(Duration(seconds: 1),(){
          emit(ContactUsInitial());
        });
      },
    );
  }
}
