import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

class CustomFadeRoute extends CustomRoute implements AutoRoute {
  CustomFadeRoute({
    required super.page,
    super.guards,
    super.path,
    super.children,
  }) : super(
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return FadeTransition(opacity: animation, child: child);
          },
          durationInMilliseconds: 300,
          reverseDurationInMilliseconds: 300,
        );
}
