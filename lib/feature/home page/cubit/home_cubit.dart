import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:walaa_customer/core/remote/service.dart';

import '../models/providers_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.api) : super(HomeInitial()) {
    getAllProviders();
  }

  final ServiceApi api;

  List<ProviderModel> providerModelList = [];

  getAllProviders() async {
    emit(HomeProvidersLoading());
    final response = await api.getAllProviders();
    response.fold((l) => emit(HomeProvidersError()), (r) {
      providerModelList = r.data!;
      emit(HomeProvidersLoaded());
      print('success :\n ${r.toJson()}');
    });
  }

// Future<List<Map<String, String>>> getSuggestions(String pattern) async {
//   final response = await serviceApi.getClients(pattern);
//   if (response.status.code == 200) {
//     print(response.data);
//     userList = response.data;
//     return Future.value(userList
//         .map((e) => {'name': e.name, 'phone': e.phone.toString()})
//         .toList());
//
//     // if (categoryList.length > 0) {
//     //   getProduct(usermodel, categoryList.elementAt(0).id);
//     // }
//   } else {
//     return Future.value(userList
//         .map((e) => {'name': e.name.toString(), 'phone': e.phone.toString()})
//         .toList());
//     //print(response.status.message);
//     //  emit(AllCategoryError());
//   }
// }
}
