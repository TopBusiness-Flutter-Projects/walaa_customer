part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}
class SettingsLoaded extends SettingsState {}
class SettingsError extends SettingsState {}
