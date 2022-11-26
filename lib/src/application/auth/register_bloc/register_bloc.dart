import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';

part 'register_state.dart';

part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState.initial()) {
    on<EmailChanged>((event, emit) {
      this.changeEmail(event, emit);
    });

    on<PasswordChanged>((event, emit) {
      this.changePassword(event, emit);
    });

    on<RegisterWithEmailAndPasswordPressed>((event, emit) {
      this.registerWithEmailAndPasswordPressed(event, emit);
    });
  }

  void changeEmail(EmailChanged event, Emitter<RegisterState> emit) {
    debugPrint("changeEmail" + event.email);
    emit(state.copyWith(
      emailAddress: event.email,
    ));
  }

  void changePassword(PasswordChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(
      password: event.password,
    ));
  }

  void registerWithEmailAndPasswordPressed(
      RegisterWithEmailAndPasswordPressed event, Emitter<RegisterState> emit) {
    emit(state.copyWith(
      isSubmitting: true,
    ));
  }
}
