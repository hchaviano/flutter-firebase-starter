import 'package:firebasestarter/app/app.dart';
import 'package:firebasestarter/login/login.dart';
import 'package:firebasestarter/home/home.dart';
import 'package:flutter/material.dart';
import 'package:firebasestarter/onboarding/view/onboarding_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetermineAccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final status = context.select((AppBloc bloc) => bloc.state.status);

    if (status == AppStatus.firstTime) return const OnBoardingScreen();

    if (status == AppStatus.notFirstTime) {
      return const _DetermineAccessScreen();
    }

    return const SplashScreen();
  }
}

class _DetermineAccessScreen extends StatelessWidget {
  const _DetermineAccessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.loggedIn)
          Navigator.of(context).pushReplacement(HomeScreen.route());
        else
          Navigator.of(context).pushReplacement(LoginScreen.route());
      },
      child: const SplashScreen(),
    );
  }
}
