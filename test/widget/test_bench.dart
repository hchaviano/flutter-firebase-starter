import 'package:firebasestarter/bloc/employees/employees_bloc.dart';
import 'package:firebasestarter/bloc/employees/employees_event.dart';
import 'package:firebasestarter/bloc/init_app/init_app_bloc.dart';
import 'package:firebasestarter/bloc/init_app/init_app_event.dart';
import 'package:firebasestarter/bloc/login/login_bloc.dart';
import 'package:firebasestarter/bloc/login/login_event.dart';
import 'package:firebasestarter/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:repository/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_bench_mocks.dart';

extension TestBench on WidgetTester {
  Future<void> pumpApp(
    Widget widgetUnderTest, {
    EmployeesRepository employeesRepository,
    InitAppBloc initAppBloc,
    LoginBloc loginBloc,
    UserBloc userBloc,
    EmployeesBloc employeesBloc,
    TargetPlatform platform,
    bool hasScaffold = true,
  }) async {
    assert(widgetUnderTest != null);
    await pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<InitAppBloc>(
            create: (_) {
              final bloc = initAppBloc ?? MockInitAppBloc();
              return bloc..add(const InitAppIsFirstTime());
            },
          ),
          BlocProvider<LoginBloc>(
            create: (_) {
              final bloc = loginBloc ?? MockLoginBloc();
              return bloc..add(const IsUserLoggedIn());
            },
          ),
          BlocProvider<UserBloc>(
            create: (_) {
              final bloc = userBloc ?? MockUserBloc();
              return bloc..add(const UserLoaded());
            },
          ),
          BlocProvider<EmployeesBloc>(
            create: (_) {
              final bloc = employeesBloc ??
                  EmployeesBloc(
                    employeesRepository ?? MockEmployeesRepository(),
                  );
              return bloc..add(const EmployeesLoaded());
            },
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: hasScaffold ? Scaffold(body: widgetUnderTest) : widgetUnderTest,
        ),
      ),
    );
    await pump();
  }
}
