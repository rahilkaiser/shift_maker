part of 'theme_mode_bloc.dart';

@freezed
class ThemeModeEvent with _$ThemeModeEvent {
  const factory ThemeModeEvent.ThemeModeSytemSelectEvent() = ThemeModeSytemSelectEvent;

  const factory ThemeModeEvent.ThemeModeLightSelectEvent() = ThemeModeLightSelectEvent;

  const factory ThemeModeEvent.ThemeModeDarkSelectEvent() = ThemeModeDarkSelectEvent;
}

