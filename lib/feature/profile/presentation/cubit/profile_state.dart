part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileGetUserModel extends ProfileState {}

class ProfileDeleteAccountLoading extends ProfileState {}
class ProfileDeleteAccountLoaded extends ProfileState {}
class ProfileDeleteAccountError extends ProfileState {}
