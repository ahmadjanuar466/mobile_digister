import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class NotificationWidget {
  static ToastificationItem show({
    required String title,
    required String description,
    required ToastificationType type,
  }) =>
      toastification.show(
        type: type,
        style: ToastificationStyle.flat,
        title: Text(title),
        description: Text(description),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 4),
        animationBuilder: (
          context,
          animation,
          alignment,
          child,
        ) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: lowModeShadow,
        showProgressBar: true,
        dragToClose: true,
      );
}
