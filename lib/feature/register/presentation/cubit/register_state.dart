part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterPickImageSuccess extends RegisterState {}

class RegisterUserData extends RegisterState {}

class RegisterUpdateLoading extends RegisterState {}
class RegisterUpdateLoaded extends RegisterState {
  final LoginModel loginModel;
  RegisterUpdateLoaded(this.loginModel);
}
class RegisterUpdateError extends RegisterState {}