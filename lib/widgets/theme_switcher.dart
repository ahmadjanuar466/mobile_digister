import 'dart:async';

import 'package:flutter/material.dart';

class ThemeSwitcher extends InheritedWidget {
  ThemeSwitcher({
    super.key,
    required super.child,
  });

  final StreamController<ThemeData> streamController = StreamController();

  static ThemeSwitcher? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeSwitcher>();
  }

  @override
  bool updateShouldNotify(ThemeSwitcher oldWidget) {
    return oldWidget != this;
  }
}
