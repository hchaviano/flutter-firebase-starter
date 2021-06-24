import 'package:firebasestarter/bloc/forgot_password/forgot_password_event.dart';
import 'package:firebasestarter/bloc/forgot_password/forgot_password_state.dart';
import 'package:firebasestarter/services/auth/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  AuthService _authService;

  static const _recoverPasswordErr =
      'Error: Something went wrong while trying to recover password';

  ForgotPasswordBloc({
    AuthService authService,
  }) : super(const ForgotPasswordState()) {
    _authService = authService ?? GetIt.I<AuthService>();
  }

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {
    if (event is PasswordReset) {
      yield* _mapPasswordResetToState();
    } else if (event is EmailAddressUpdated) {
      yield* _mapEmailAddressUpdated(event.emailAddress);
    }
  }

  Stream<ForgotPasswordState> _mapPasswordResetToState() async* {
    yield state.copyWith(status: ForgotPasswordStatus.inProgress);
    try {
      await _authService.sendPasswordResetEmail(state.emailAddress);
      yield state.copyWith(status: ForgotPasswordStatus.emailSent);
    } catch (e) {
      yield state.copyWith(
        status: ForgotPasswordStatus.failure,
        errorMessage: _recoverPasswordErr,
      );
    }
  }

  Stream<ForgotPasswordState> _mapEmailAddressUpdated(String email) async* {
    yield state.copyWith(emailAddress: email);
  }
}
