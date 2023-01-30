import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:walaa_customer/core/remote/service.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.api) : super(SettingsInitial()){
    getSettings();
  }

  final ServiceApi api;

  late String privacyAr;
  late String privacyEn;
  late String termsAr;
  late String termsEn;

  getSettings() async {
    emit(SettingsLoading());
    final response = await api.getSetting();
    response.fold(
      (l) => emit(SettingsError()),
      (r) {
        privacyEn = r.data.privacyEn;
        privacyAr = r.data.privacyAr;
        termsAr = r.data.termsAr;
        termsEn = r.data.termsEn;

        emit(SettingsLoaded());
      },
    );
  }
}
