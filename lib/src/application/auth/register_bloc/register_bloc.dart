import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

import '../../../core/util/failures/auth_failures/auth_failure.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'register_event.dart';

part 'register_state.dart';

part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc({required this.authRepository}) : super(RegisterState.initial()) {
    on<EmailChanged>((event, emit) {
      this.changeEmail(event, emit);
    });

    on<PasswordChanged>((event, emit) {
      this.changePassword(event, emit);
    });

    on<RegisterWithEmailAndPasswordPressed>((event, emit) async {
      await this.registerWithEmailAndPasswordPressed(event, emit);
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

  Future<void> registerWithEmailAndPasswordPressed(
      RegisterWithEmailAndPasswordPressed event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(
      isSubmitting: true,
      failureOrSuccessOption: none(),
    ));

    final failureOrSuccess = await this
        .authRepository
        .registerWithEmailAndPasswort(emailAddress: state.emailAddress, password: state.password);

    emit(state.copyWith(
      isSubmitting: false,
      failureOrSuccessOption: optionOf(failureOrSuccess),
    ));
  }
}
