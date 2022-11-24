import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_bloc_event.dart';

part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthState> {
  AuthBloc() : super(AuthState(isSubmitting: false, showValidationMessages: false)) {
    on<RegisterWithEmailAndPasswordPressed>((event, emit) {
      emit(AuthState(isSubmitting: false, showValidationMessages: true));

    });

    on<LoginWithEmailAndPasswordPressed>((event, emit) {
      if(event.email == null || event.password == null) {
        emit(AuthState(isSubmitting: false, showValidationMessages: true));
      } else {
        emit(AuthState(isSubmitting: true, showValidationMessages: false));
        // TODO: Trigger authentication
      }

    });
  }
}
