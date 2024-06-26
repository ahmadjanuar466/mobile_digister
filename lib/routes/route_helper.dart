import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RouteHelper {
  static Future<dynamic> push(
    BuildContext context, {
    required Widget widget,
    required PageTransitionType transitionType,
  }) =>
      Navigator.push(
        context,
        PageTransition(
          child: widget,
          type: transitionType,
          settings: RouteSettings(
            name: widget.toStringShort(),
          ),
        ),
      );

  static Future<dynamic> pushReplacement(
    BuildContext context, {
    required Widget widget,
    required PageTransitionType transitionType,
  }) =>
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: widget,
          type: transitionType,
          settings: RouteSettings(
            name: widget.toStringShort(),
          ),
        ),
      );

  static Future<dynamic> pushAndRemoveUntil(
    BuildContext context, {
    required Widget widget,
    required PageTransitionType transitionType,
  }) =>
      Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          child: widget,
          type: transitionType,
          settings: RouteSettings(
            name: widget.toStringShort(),
          ),
        ),
        (route) => false,
      );

  static void pop(BuildContext context) => Navigator.pop(context);

  static void popUntil(
    BuildContext context, {
    required String routeName,
  }) =>
      Navigator.popUntil(
        context,
        (route) => route.settings.name == routeName,
      );
}
