import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:walaa_customer/core/api/base_api_consumer.dart';
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
import '../models/home_model.dart';
import '../models/login_model.dart';
import '../models/response_message.dart';
import '../models/search_product_model.dart';

class ServiceApi {
  final BaseApiConsumer dio;

  ServiceApi(this.dio);

  Future<Either<Failure, LoginModel>> postLogin(String phone) async {
    try {
      final response = await dio.post(
        EndPoints.loginUrl,
        body: {
          'phone': phone,
          'phone_code': AppStrings.phoneCode,
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
      String token, double amount) async {
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

  Future<Either<Failure, ProviderListModel>> getAllProviders() async {
    try {
      // LoginModel loginModel = await Preferences.instance.getUserModel();
      String lan = await Preferences.instance.getSavedLang();
      final response = await dio.get(
        EndPoints.providersUrl,
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

  Future<Either<Failure, HomeModel>> getHomeData() async {
    try {
      LoginModel loginModel = await Preferences.instance.getUserModel();
      String lan = await Preferences.instance.getSavedLang();
      final response = await dio.get(
        EndPoints.homeUrl,
        options: Options(
          headers: {
            'Authorization': loginModel.data!.accessToken,
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
}
