part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileGetUserModel extends ProfileState {}

class ProfileDeleteAccountLoading extends ProfileState {}
class ProfileDeleteAccountLoaded extends ProfileState {}
class ProfileDeleteAccountError extends ProfileState {}
class OnUrlPayLoaded extends ProfileState {
  final RechargeWalletModel data;
  OnUrlPayLoaded(this.data);
}

class ProfilePackageLoading extends ProfileState {}
class ProfilePackageLoaded extends ProfileState {}
class ProfilePackageError extends ProfileState {}
