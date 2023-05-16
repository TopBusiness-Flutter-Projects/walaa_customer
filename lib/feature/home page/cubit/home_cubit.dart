import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:walaa_customer/core/remote/service.dart';

import '../../../core/models/home_model.dart';
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
}
