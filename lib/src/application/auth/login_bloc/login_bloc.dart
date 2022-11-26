import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<EmailChanged>((event, emit) {
      this.changeEmail(event, emit);
    });

    on<PasswordChanged>((event, emit) {
      this.changePassword(event, emit);
    });

    on<LoginWithEmailAndPasswordPressed>((event, emit) {
      this.loginWithEmailAndPasswordPressed(event, emit);
    });
  }

  void changeEmail(EmailChanged event, Emitter<LoginState> emit) {
    debugPrint("changeEmail " + event.email);
    emit(state.copyWith(
      emailAddress: event.email,
    ));
  }

  void changePassword(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      password: event.password,
    ));
  }

  void loginWithEmailAndPasswordPressed(LoginWithEmailAndPasswordPressed event, Emitter<LoginState> emit) {

    emit(state.copyWith(
      isSubmitting: true,
    ));
  }
}
