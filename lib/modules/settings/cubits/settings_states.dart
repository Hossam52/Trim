abstract class SettingsStatates {}

class IntialSettingState extends SettingsStatates {}

class LoadingContactsSettingState extends SettingsStatates {}

class LoadedContactsSettingState extends SettingsStatates {}

class ErrorSettingState extends SettingsStatates {
  final String error;

  ErrorSettingState(this.error);
}

class LoadingPersonalDataState extends SettingsStatates {}

class LoadedPersonalDataState extends SettingsStatates {}

class LoadingNotificationState extends SettingsStatates {}

class NoMoreNotificationsState extends SettingsStatates {}

class LoadedNotificationState extends SettingsStatates {}

class ErrorNotificationState extends SettingsStatates {
  final String error;

  ErrorNotificationState(this.error);
}
