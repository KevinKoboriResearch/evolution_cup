import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FadeAnimationPage extends Page {
  final Widget child;
  const FadeAnimationPage({Key key, this.child}) : super(key: key);

  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, animation2) => child,
      transitionDuration: const Duration(seconds: 0),
    );
  }
}
