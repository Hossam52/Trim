abstract class SettingsStatates {}

class IntialSettingState extends SettingsStatates {}

class LoadingContactsSettingState extends SettingsStatates {}

class LoadedContactsSettingState extends SettingsStatates {}

class ErrorSettingState extends SettingsStatates {
  final String error;

  ErrorSettingState(this.error);
}
