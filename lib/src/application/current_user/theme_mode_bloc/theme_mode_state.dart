part of 'theme_mode_bloc.dart';

@freezed
class ThemeModeSelectionState with _$ThemeModeSelectionState {
  factory ThemeModeSelectionState({
    required ThemeMode themeMode,
  }) = _ThemeModeSelectionState;

    const ThemeModeSelectionState._();

  factory ThemeModeSelectionState.initial() => ThemeModeSelectionState(
        themeMode: ThemeMode.dark
      );
}
