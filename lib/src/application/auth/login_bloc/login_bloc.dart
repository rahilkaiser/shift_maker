import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

import '../../../core/util/failures/auth_failures/auth_failure.dart';
import '../../../domain/repositories/auth/auth_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginState.initial()) {
    on<EmailChanged>((event, emit) {
      this.changeEmail(event, emit);
    });

    on<PasswordChanged>((event, emit) {
      this.changePassword(event, emit);
    });

    on<LoginWithEmailAndPasswordPressed>((event, emit) async {
      await this.loginWithEmailAndPasswordPressed(event, emit);
    });
  }

  void changeEmail(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      emailAddress: event.email,
    ));
  }

  void changePassword(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      password: event.password,
    ));
  }

  Future<void> loginWithEmailAndPasswordPressed(
      LoginWithEmailAndPasswordPressed event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
      isSubmitting: true,
      failureOrSuccessOption: none(),
    ));
    final failureOrSuccess = await this
        .authRepository
        .loginWithEmailAndPasswort(
            emailAddress: state.emailAddress, password: state.password);

    emit(state.copyWith(
      isSubmitting: false,
      failureOrSuccessOption: optionOf(failureOrSuccess),
    ));
  }
}
