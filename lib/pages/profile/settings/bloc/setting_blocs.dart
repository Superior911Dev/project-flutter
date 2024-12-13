import 'package:appstore/pages/profile/settings/bloc/setting_events.dart';
import 'package:appstore/pages/profile/settings/bloc/settings_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsBlocs extends Bloc<SettingsEvents, SettingStates> {
  SettingsBlocs() : super(const SettingStates()) {
    on<TriggerSettings>(_triggerSettings);
  }
  _triggerSettings(SettingsEvents events, Emitter<SettingStates> emit) {
    emit(const SettingStates());
  }
}
