import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/base_language_repository.dart';

class GetSavedLanguageUseCase implements UseCase<String?, NoParams> {
  final BaseLanguageRepository languageRepository;

  const GetSavedLanguageUseCase({required this.languageRepository});
  @override
  Future<Either<Failure, String?>> call(NoParams params) async =>
      await languageRepository.getSavedLanguage();
}