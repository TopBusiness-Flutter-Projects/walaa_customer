import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/base_language_repository.dart';

class ChangeLanguageUseCase implements UseCase<bool, String> {
  final BaseLanguageRepository languageRepository;

  const ChangeLanguageUseCase({required this.languageRepository});

  @override
  Future<Either<Failure, bool>> call(String languageCode) async =>
      await languageRepository.changeLanguage(languageCode: languageCode);
}