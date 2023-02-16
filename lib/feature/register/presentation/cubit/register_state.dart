part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterPickImageSuccess extends RegisterState {}

class RegisterUserData extends RegisterState {}

class RegisterUpdateLoading extends RegisterState {}

class RegisterUpdateLoaded extends RegisterState {
  final LoginModel loginModel;

  RegisterUpdateLoaded(this.loginModel) {
    Preferences.instance.setUser(loginModel);
  }
}

class RegisterUpdateError extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {
  final LoginModel loginModel;

  RegisterLoaded(this.loginModel) {
    Preferences.instance.setUser(loginModel);
  }
}

class RegisterError extends RegisterState {}
