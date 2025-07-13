import 'package:flutter/material.dart';

class NavHelper {
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

  static addWithAnimation(Widget widget, {Function? callback}) {
    navigatorKey.currentState!
        .push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => widget,
            transitionDuration: Duration(milliseconds: 600),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = 0.0;
                  const end = 1.0;
                  const curve = Curves.easeOutCubic;

                  var tween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: curve));

                  return FadeTransition(
                    opacity: animation.drive(tween),
                    child: child,
                  );
                },
          ),
        )
        .then((value) {
          if (callback != null && value != null) callback(value);
        });
  }

  static replace(Widget widget, {Function? callback}) {
    navigatorKey.currentState!
        .pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => widget,
            transitionDuration: Duration(milliseconds: 600),

            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = 0.0;
                  const end = 1.0;
                  const curve = Curves.easeOutCubic;

                  var tween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: curve));

                  return FadeTransition(
                    opacity: animation.drive(tween),
                    child: child,
                  );
                },
          ),
        )
        .then((value) {
          if (callback != null && value != null) callback(value);
        });
  }

  static remove({dynamic value}) {
    navigatorKey.currentState!.pop(value ?? false);
  }

  static removeAllAndOpen(Widget widget) {
    navigatorKey.currentState!.pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionDuration: Duration(milliseconds: 600),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ),
      (Route<dynamic> route) => false,
    );
  }
}
