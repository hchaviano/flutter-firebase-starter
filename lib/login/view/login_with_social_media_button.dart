import 'package:firebasestarter/constants/assets.dart';
import 'package:firebasestarter/login/login.dart';
import 'package:firebasestarter/services/auth/auth.dart';
import 'package:firebasestarter/widgets/common/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class LoginWithSocialMediaButton extends StatelessWidget {
  const LoginWithSocialMediaButton({Key key}) : super(key: key);

  SocialMediaMethod get socialMediaMethod;

  String get asset;

  String text(BuildContext context);

  void _onTap(BuildContext context) {
    context
        .read<LoginBloc>()
        .add(LoginWithSocialMediaRequested(method: socialMediaMethod));
  }

  @override
  Widget build(BuildContext context) {
    return Button(
      onTap: () => _onTap(context),
      backgroundColor: Colors.white,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
          ),
          Image(
            image: AssetImage(asset),
            height: 30.0,
            width: 30.0,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
          ),
          Text(
            text(context),
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class LoginWithGoogleButton extends LoginWithSocialMediaButton {
  const LoginWithGoogleButton({Key key}) : super(key: key);

  @override
  SocialMediaMethod get socialMediaMethod => SocialMediaMethod.google;

  @override
  String get asset => Assets.googleLogo;

  @override
  String text(BuildContext context) {
    return AppLocalizations.of(context).googleSignIn;
  }
}

class LoginWithFacebookButton extends LoginWithSocialMediaButton {
  const LoginWithFacebookButton({Key key}) : super(key: key);

  @override
  SocialMediaMethod get socialMediaMethod => SocialMediaMethod.facebook;

  @override
  String get asset => Assets.facebookLogo;

  @override
  String text(BuildContext context) {
    return AppLocalizations.of(context).facebookSignIn;
  }
}

class LoginWithAppleButton extends LoginWithSocialMediaButton {
  const LoginWithAppleButton({Key key}) : super(key: key);

  @override
  SocialMediaMethod get socialMediaMethod => SocialMediaMethod.apple;

  @override
  String get asset => Assets.appleLogo;

  @override
  String text(BuildContext context) {
    return AppLocalizations.of(context).appleIdSignIn;
  }
}

class LoginAnonymouslyButton extends StatelessWidget {
  const LoginAnonymouslyButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Button(
      onTap: () {
        context.read<LoginBloc>().add(const LoginAnonymouslyRequested());
      },
      backgroundColor: Colors.white,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
          ),
          const Image(
            image: AssetImage(Assets.anonLogin),
            height: 30.0,
            width: 30.0,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
          ),
          Text(
            localizations.anonymousSignIn,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
