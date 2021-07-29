import 'package:auth/auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebasestarter/data_source/data_source.dart';
import 'package:firebasestarter/employees/employees.dart';
import 'package:firebasestarter/login/login.dart';
import 'package:firebasestarter/app/app.dart';
import 'package:firebasestarter/services/analytics/analyitics.dart';
import 'package:firebasestarter/services/app_info/app_info_service.dart';
import 'package:firebasestarter/services/image_picker/image_picker.dart';
import 'package:firebasestarter/services/notifications/notifications_service.dart';
import 'package:firebasestarter/services/shared_preferences/shared_preferences.dart';
import 'package:firebasestarter/services/storage/firebase_storage_service.dart';
import 'package:firebasestarter/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:repository/repository.dart';

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: MySharedPreferences()),
        RepositoryProvider.value(
            value: FirebaseInitService().init([
          SocialMediaMethod.apple,
          SocialMediaMethod.facebook,
          SocialMediaMethod.google
        ])),
        RepositoryProvider.value(value: SignInServiceFactory()),
        RepositoryProvider.value(value: FirebaseAnalyticsService()),
        RepositoryProvider.value(value: FirebaseStorageService()),
        RepositoryProvider.value(value: NotificationService()),
        RepositoryProvider.value(value: AppInfoService()),
        RepositoryProvider.value(value: PickImageService()),
        RepositoryProvider.value(value: FirebaseAnalytics()),
        RepositoryProvider.value(
          value: EmployeesRepository(
            FirebaseEmployeeDatabase(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            create: (context) => AppBloc(
                localPersistanceService: context.read<MySharedPreferences>())
              ..add(const AppIsFirstTimeLaunched()),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              authService: context.read<FirebaseAuthService>(),
              analyticsService: context.read<FirebaseAnalyticsService>(),
            )..add(const LoginIsSessionPersisted()),
          ),
          BlocProvider(
            create: (context) =>
                UserBloc(authService: context.read<FirebaseAuthService>())
                  ..add(const UserLoaded()),
          ),
          BlocProvider(
            create: (context) => EmployeesBloc(
              context.read<EmployeesRepository>(),
            )..add(const EmployeesLoaded()),
          ),
        ],
        child: const FirebaseStarter(),
      ),
    );
  }
}

class FirebaseStarter extends StatefulWidget {
  const FirebaseStarter({Key key}) : super(key: key);

  @override
  _FirebaseStarterState createState() => _FirebaseStarterState();
}

class _FirebaseStarterState extends State<FirebaseStarter> {
  NotificationService _notificationService;

  @override
  void initState() {
    _notificationService = context.read<NotificationService>();
    _notificationService.configure();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const DetermineAccessScreen(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(
          analytics: context.read<FirebaseAnalytics>(),
        ),
      ],
    );
  }
}
