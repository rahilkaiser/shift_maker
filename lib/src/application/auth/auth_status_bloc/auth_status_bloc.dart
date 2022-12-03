import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

import '../../../domain/repositories/auth/auth_repository.dart';

part 'auth_status_event.dart';

part 'auth_status_state.dart';

part 'auth_status_bloc.freezed.dart';

class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthStatusState> {
  final AuthRepository authRepository;

  AuthStatusBloc({required this.authRepository}) : super(const AuthStatusState.initial()) {
    on<AuthCheckRequested>((event, emit) async {
      await this.authCheckRequested(event, emit);
    });

    on<Logout>((event, emit) async {
      await this.logoutUser(event, emit);
    });
  }

  Future<void> authCheckRequested(AuthStatusEvent event, Emitter<AuthStatusState> emit) async {
    final userOption = await authRepository.getSignedInUser();

    userOption.fold(
      () => emit(const AuthStatusState.unauthenticated()),
      (a) => emit(const AuthStatusState.authenticated()),
    );
  }

  Future<void> logoutUser(Logout event, Emitter<AuthStatusState> emit) async {
    await authRepository.logout();
    emit(const AuthStatusState.unauthenticated());
  }
}
