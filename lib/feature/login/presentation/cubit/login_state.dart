part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}


class SendCodeLoading extends LoginState {}
class OnSmsCodeSent extends LoginState {
  final String smsCode;

  OnSmsCodeSent(this.smsCode);
}
class CheckCodeInvalidCode extends LoginState {}
class CheckCodeSuccessfully extends LoginState {}

class LoginLoading extends LoginState {}
class LoginLoaded extends LoginState {}
class LoginFailure extends LoginState {}

