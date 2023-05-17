// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/models/cart_model.dart';

import '../../../core/preferences/preferences.dart';



part 'navigator_bottom_state.dart';

class NavigatorBottomCubit extends Cubit<NavigatorBottomState> {
  NavigatorBottomCubit() : super(NavigatorBottomInitial()){
    onUserDataSuccess();
  }
  int page = 0;
  String title='home';
  String lan ='ff';

  String size='0';

  onUserDataSuccess() async {
   // user = await Preferences.instance.getUserModel().whenComplete(() => null);
    getCartSize();
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
}
