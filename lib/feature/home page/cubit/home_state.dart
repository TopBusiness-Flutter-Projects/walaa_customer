part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeProvidersLoading extends HomeState {}
class HomeProvidersLoaded extends HomeState {}
class HomeProvidersError extends HomeState {}
class ChangeCurrentIndexTap extends HomeState {}

