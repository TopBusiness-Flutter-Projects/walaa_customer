import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:walaa_customer/core/api/base_api_consumer.dart';
import 'package:walaa_customer/core/utils/app_strings.dart';

import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import '../models/login_model.dart';

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

// Future<ContactUsModel> contactUsApi(
//     SendContactUsModel sendContactUsModel) async {
//   try {
//     print(EndPoints.contactUsUrl);
//     Response response = await dio.post(EndPoints.contactUsUrl,
//         data: sendContactUsModel.toJson());
//     print('Url : ${EndPoints.contactUsUrl}');
//     print('Response : \n ${response.data}');
//     return ContactUsModel.fromJson(response.data);
//   } on DioError catch (e) {
//     print(" Error : ${e}");
//     final errorMessage = DioExceptions.fromDioError(e).toString();
//     throw errorMessage;
//   }
// }
}
