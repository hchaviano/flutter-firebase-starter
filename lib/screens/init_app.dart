import 'package:firebasestarter/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebasestarter/bloc/init_app/init_app_bloc.dart';
import 'package:firebasestarter/bloc/init_app/init_app_state.dart';
import 'package:firebasestarter/bloc/login/login_bloc.dart';
import 'package:firebasestarter/bloc/login/login_state.dart';
import 'package:firebasestarter/screens/auth/login_screen.dart';
import 'package:firebasestarter/screens/onboarding/onboarding_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash.dart';

class DetermineAccessScreen extends StatelessWidget {
  Widget _checkIfUserIsLoggedIn() => BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state.status == LoginStatus.initial) {
            return Splash();
          }
          if (state.status == LoginStatus.loginSuccess) {
            return HomeScreen(state.currentUser);
          }
          return LoginScreen();
        },
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitAppBloc, InitAppState>(
      builder: (context, initAppState) {
        if (initAppState.status == InitAppStatus.firstTime) {
          return OnBoardingScreen();
        }
        if (initAppState.status == InitAppStatus.notFirstTime) {
          return _checkIfUserIsLoggedIn();
        }
        return Splash();
      },
    );
  }
}
