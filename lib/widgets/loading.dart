import 'package:firebase_starter_ui/firebase_starter_ui.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final String loadingMessage;

  const LoadingIndicator({
    Key key,
    this.loadingMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: FSColors.black,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 24),
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(FSColors.black),
          ),
        ],
      ),
    );
  }
}
