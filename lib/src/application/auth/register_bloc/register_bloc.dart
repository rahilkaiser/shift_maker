import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

import '../../../core/util/failures/auth_failures/auth_failure.dart';
import '../../../domain/repositories/auth/auth_repository.dart';

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

    on<NameChanged>((event, emit) {
      this.changeName(event, emit);
    });

    on<PhoneNumberChanged>((event, emit) {
      this.changePhoneNum(event, emit);
    });

    on<RegisterWithEmailAndPasswordPressed>((event, emit) async {
      await this.registerWithEmailAndPasswordPressed(event, emit);
    });
  }

  void changeEmail(EmailChanged event, Emitter<RegisterState> emit) {
    debugPrint("changeEmail" + event.email);
    debugPrint("changePASS" + state.password);
    debugPrint("changeNAME" + state.name);
    debugPrint("changePHONE" + state.phoneNum);

    emit(state.copyWith(
      emailAddress: event.email,
    ));
  }

  void changePassword(PasswordChanged event, Emitter<RegisterState> emit) {
    debugPrint("changeEmail" + state.emailAddress);
    debugPrint("changePASS" + event.password);
    debugPrint("changeNAME" + state.name);
    debugPrint("changePHONE" + state.phoneNum);
    emit(state.copyWith(
      password: event.password,
    ));
  }

  void changeName(NameChanged event, Emitter<RegisterState> emit) {
    debugPrint("changeEmail" + state.emailAddress);
    debugPrint("changePASS" + state.password);
    debugPrint("changeNAME" + event.name);
    debugPrint("changePHONE" + state.phoneNum);
    emit(state.copyWith(
      name: event.name,
    ));
  }

  void changePhoneNum(PhoneNumberChanged event, Emitter<RegisterState> emit) {
    debugPrint("changeEmail" + state.emailAddress);
    debugPrint("changePASS" + state.password);
    debugPrint("changeNAME" + state.name);
    debugPrint("changePHONE" + event.phoneNum);
    emit(state.copyWith(
      phoneNum: event.phoneNum,
    ));
  }

  Future<void> registerWithEmailAndPasswordPressed(RegisterWithEmailAndPasswordPressed event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(
      isSubmitting: true,
      failureOrSuccessOption: none(),
    ));

    final failureOrSuccess = await this.authRepository.registerWithEmailAndPasswort(
          emailAddress: state.emailAddress,
          password: state.password,
          name: state.name,
          phoneNumber: state.phoneNum,
        );

    emit(state.copyWith(
      isSubmitting: false,
      failureOrSuccessOption: optionOf(failureOrSuccess),
    ));
  }
}
