import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'theme_mode_event.dart';

part 'theme_mode_state.dart';

part 'theme_mode_bloc.freezed.dart';

class ThemeModeBloc extends Bloc<ThemeModeEvent, ThemeModeSelectionState> {
  ThemeModeBloc() : super(ThemeModeSelectionState.initial()) {
    on<ThemeModeSytemSelectEvent>((event, emit) {
      emit(ThemeModeSelectionState(themeMode: ThemeMode.system));
    });
    on<ThemeModeLightSelectEvent>((event, emit) {
      emit(ThemeModeSelectionState(themeMode: ThemeMode.light));
    });

    on<ThemeModeDarkSelectEvent>((event, emit) {
      emit(ThemeModeSelectionState(themeMode: ThemeMode.dark));
    });
  }
}
