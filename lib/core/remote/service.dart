import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:walaa_customer/core/api/base_api_consumer.dart';
import 'package:walaa_customer/core/error/exceptions.dart';
import 'package:walaa_customer/core/preferences/preferences.dart';
import 'package:walaa_customer/core/models/recharge_wallet_model.dart';
import 'package:walaa_customer/core/utils/app_strings.dart';

import '../../feature/contact us/models/contact_us_model.dart';
import '../../feature/home page/models/providers_model.dart';
import '../../feature/menu/models/product_data_model.dart';
import '../../feature/privacy_terms/models/settings.dart';
import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import '../models/cart_model.dart';
import '../models/home_model.dart';
import '../models/login_model.dart';
import '../models/order_data_model.dart';
import '../models/payment_package_model.dart';
import '../models/search_phone_model.dart';
import '../models/single_order_detials.dart';
import '../models/search_product_model.dart';
import '../models/status_resspons.dart';

class ServiceApi {
  final BaseApiConsumer dio;

  ServiceApi(this.dio);

  Future<Either<Failure, LoginModel>> postLogin(String phone, String phoneCode) async {
    try {
      final response = await dio.post(
        EndPoints.loginUrl,
        body: {
          'phone': phone,
          'phone_code': phoneCode,
        },
      );
      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, ContactUsModel>> contactUsApi(
      ContactUsData contactUsData) async {
    try {
      final response = await dio.post(
        EndPoints.contactUsUrl,
        body: contactUsData.toJson(),
      );
      return Right(ContactUsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LoginModel>> updateProfile(UserData userData) async {
    print('++++++++++++++++++++++++++++++++++++++++++++++++');
    print(await userData.updateToJson());
    try {
      final response = await dio.post(
        formDataIsEnabled: true,
        EndPoints.updateProfileUrl,
        body: await userData.updateToJson(),
        options: Options(
          headers: {
            'Authorization': userData.token,
          },
        ),
      );
      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, SettingModel>> getSetting() async {
    try {
      final response = await dio.get(
        EndPoints.settingUrl,
      );
      return Right(SettingModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, StatusResponse>> deleteAccount(String token) async {
    try {
      final response = await dio.post(
        EndPoints.deleteAccountUrl,
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );
      return Right(StatusResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, RechargeWalletModel>> chargeWallet(
      String token, int amount) async {
    try {
      final response = await dio.get(EndPoints.chargeWalletUrl,
          options: Options(
            headers: {
              'Authorization': token,
            },
          ),
          queryParameters: {'amount': amount});
      return Right(RechargeWalletModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LoginModel>> registerUser(UserData userData) async {
    try {
      final response = await dio.post(
        EndPoints.registerUrl,
        formDataIsEnabled: true,
        body: await userData.updateToJson(),
      );
      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LoginModel>> getprofile(String token) async {
    try {
      final response = await dio.get(
        EndPoints.profileUrl,
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );
      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, ProviderListModel>> getAllProviders(int provider_type) async {
    try {
      // LoginModel loginModel = await Preferences.instance.getUserModel();
      String lan = await Preferences.instance.getSavedLang();
      final response = await dio.get(
        EndPoints.providersUrl,
        queryParameters: {
          "provider_type":provider_type
        },
        options: Options(
          headers: {
            // 'Authorization': loginModel.data!.accessToken,
            'Accept-Language': lan,
          },
        ),
      );
      return Right(ProviderListModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, HomeModel>> getHomeData(int provider_type) async {
    try {
      LoginModel loginModel = await Preferences.instance.getUserModel();
      String? token;
      if (loginModel.data != null) {
        token = loginModel.data!.accessToken!;
      }
      String lan = await Preferences.instance.getSavedLang();
      final response = await dio.get(
        EndPoints.homeUrl,
        queryParameters: {
          "provider_type":provider_type
        },
        options: Options(
          headers: {
            'Authorization': token,
            'Accept-Language': lan,
          },
        ),
      );
      return Right(HomeModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, ProductModel>> getProduct(int category_id) async {
    try {
      String lan = await Preferences.instance.getSavedLang();
      // LoginModel loginModel = await Preferences.instance.getUserModel();
      final response = await dio.get(
        EndPoints.productUrl + "/${category_id}",
        options: Options(
          headers: {
            // 'Authorization': loginModel.data!.accessToken,
            'Accept-Language': lan,
          },
        ),
      );
      return Right(ProductModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, SearchProductModel>> searchProduct(
      int provider_id, String searchText) async {
    try {
      String lan = await Preferences.instance.getSavedLang();
      LoginModel loginModel = await Preferences.instance.getUserModel();
      final response = await dio.get(
        EndPoints.searchProductUrl,
        options: Options(
          headers: {
            'Authorization': loginModel.data!.accessToken,
            'Accept-Language': lan,
          },
        ),
        queryParameters: {
          'search_key': searchText,
          'provider_id': provider_id,
        },
      );
      return Right(SearchProductModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }


  Future<Either<Failure, PaymentPackageModel>> paymentPackages() async {
    try {
      String lan = await Preferences.instance.getSavedLang();
      LoginModel loginModel = await Preferences.instance.getUserModel();
      final response = await dio.get(
        EndPoints.packagesUrl,
        options: Options(
          headers: {
            'Authorization': loginModel.data!.accessToken,
            'Accept-Language': lan,
          },
        ),
      );
      return Right(PaymentPackageModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, SingleOrderDetailsModel>> sendOrder(
      CartModel model, String token) async {
    try {
      final response = await dio.post(
        EndPoints.sendOrderUrl,
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
        body: CartModel.toJson(model),
      );
      //print('Url : ${EndPoints.sendOrderUrl}');
      // print('Response : \n ${response.data}');
      return Right(SingleOrderDetailsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, StatusResponse>> addDeviceToken(
      String devicetoken,String softwareType,) async {
    LoginModel userModel=await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(
        EndPoints.tokenUrl,
        options: Options(
          headers: {
            'Authorization': userModel.data!.accessToken,
          },
        ),
        body: {
         "software_type" :softwareType,
          "phone_token":devicetoken,
          "client_id":userModel.data!.user.id
        },
      );
      //print('Url : ${EndPoints.sendOrderUrl}');
      // print('Response : \n ${response.data}');
      return Right(StatusResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

//
//   Future<Either<Failure, OrderDataModel>> getOrders(
//       String token, String lan) async {
//     try{
//     final response = await dio.post(
//       EndPoints.sendOrderUrl,
//       options: Options(
//         headers: {
//           'Authorization': token,
//         },
//       ),
//       body: CartModel.toJson(model),
//     );
//     //print('Url : ${EndPoints.sendOrderUrl}');
//    // print('Response : \n ${response.data}');
//     return Right(SingleOrderDetailsModel.fromJson(response));
//   } on ServerException {
//   return Left(ServerFailure());
// }  }
//

  Future<Either<Failure,StatusResponse>> rateProvider(String rate,String text,String provider_id) async {
     LoginModel loginModel = await Preferences.instance.getUserModel();

    try {
    final response = await dio.post(
      EndPoints.rateProviderUrl,
      options: Options(
        headers: {
          'Authorization': loginModel.data!.accessToken,
        },
      ),
      body: {
        'provider_id':provider_id,
        'value':rate,
        'comment':text
      },
    );
    //print('Url : ${EndPoints.sendOrderUrl}');
   // print('Response : \n ${response.data}');
    return Right(StatusResponse.fromJson(response));
  } on ServerException {
  return Left(ServerFailure());
}  }

  Future<Either<Failure,OrderDataModel>> getOrders(String token, String lan) async {
    try {
      final response = await dio.get(
        EndPoints.orderUrl,
        options: Options(
          headers: {
            'Authorization': token,
            'Accept-Language': lan,
          },
        ),
      );
      print('Url : ${EndPoints.orderUrl}');
      //  print('Response : \n ${response.data}');
      return Right(OrderDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }


  Future<Either<Failure, SearchPhoneModel>> searchPhone(
      String phone) async {
    try {
      String lan = await Preferences.instance.getSavedLang();
      LoginModel loginModel = await Preferences.instance.getUserModel();
      final response = await dio.get(
        EndPoints.searchPhoneUrl,
        options: Options(
          headers: {
            // 'Authorization': loginModel.data!.accessToken,
            'Accept-Language': lan,
          },
        ),
        queryParameters: {
          'search_key': phone,
        },
      );
      return Right(SearchPhoneModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
