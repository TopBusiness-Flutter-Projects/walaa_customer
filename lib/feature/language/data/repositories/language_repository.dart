
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/base_language_repository.dart';
import '../data_sources/language_locale_data_source.dart';

class LanguageRepository implements BaseLanguageRepository {
  final BaseLanguageLocaleDataSource languageLocaleDataSource;

  const LanguageRepository({required this.languageLocaleDataSource});

  @override
  Future<Either<Failure, bool>> changeLanguage(
      {required String languageCode}) async {
    try {
      final languageIsChanged = await languageLocaleDataSource.changeLanguage(
          languageCode: languageCode);
      return Right(languageIsChanged);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String?>> getSavedLanguage() async {
    try {
      final languageCode = await languageLocaleDataSource.getSavedLanguage();
      return Right(languageCode);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
