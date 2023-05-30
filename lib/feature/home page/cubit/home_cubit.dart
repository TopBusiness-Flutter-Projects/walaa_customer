import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:walaa_customer/core/remote/service.dart';

import '../../../core/models/home_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/appwidget.dart';
import '../../../core/utils/toast_message_method.dart';
import '../../../core/utils/translate_text_method.dart';
import '../models/providers_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.api) : super(HomeInitial()) {
    getHomeData();
  }

  final ServiceApi api;

  List<ProviderModel> providerModelList = [];
  List<ProviderModel> bestProviderModelList = [];
  List<SliderModel> sliderList = [];
  TextEditingController rateController = TextEditingController();
  double rating = 0.0;

  int currentIndex = 0;

  selectTap(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexTap());
  }
  // getAllProviders() async {
  //   emit(HomeProvidersLoading());
  //   final response = await api.getAllProviders();
  //   response.fold((l) => emit(HomeProvidersError()), (r) {
  //     providerModelList = r.data!;
  //     emit(HomeProvidersLoaded());
  //     print('success :\n ${r.toJson()}');
  //   });
  // }

  getHomeData() async {
    emit(HomeProvidersLoading());
    final response = await api.getHomeData();
    response.fold(
      (l) => emit(HomeProvidersError()),
      (r) {
        providerModelList = r.data!.providers!;
        bestProviderModelList = r.data!.theBestProvider!;

        sliderList = r.data!.sliders!;
        emit(HomeProvidersLoaded());
      },
    );
  }

  Future<void> rateProvider(BuildContext context, String text, double rating, String provider_id) async {
    AppWidget.createProgressDialog(context, 'wait');

    final response = await api.rateProvider(rating.toString(),text,provider_id);
    response.fold(
          (l) {
        Navigator.pop(context);

        Future.delayed(Duration(milliseconds: 300), () {
          toastMessage(
            translateText(AppStrings.errorOccurredText, context) ,
            context,
            color: AppColors.error,
          );
        });
      },
          (r) {
        if (r.code == 200) {
          getHomeData();
          Navigator.pop(context);
         Navigator.pop(context);
        }
        else {
          Navigator.pop(context);
          toastMessage(r.message, context);
        }
      },
    );
  }
}
