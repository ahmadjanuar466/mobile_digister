import 'package:digister/models/user_level_model.dart';
import 'package:digister/models/user_model.dart';
import 'package:digister/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:localstorage/localstorage.dart';
import '../models/forgot_password_model.dart';

ThemeData theme = CustomTheme.lightTheme;
bool isDarkMode = false;
int isFirst = int.tryParse(localStorage.getItem('isFirst') ?? "") ?? 1;
late User user;
late UserLevel userLevel;
List<dynamic> listSecurity = [];
final ForgotPassword forgotPasswordModel = ForgotPassword();
late String appVersion;

String? validator(String? value) {
  if (value!.isEmpty || value == "") {
    return 'Wajib diisi';
  }

  return null;
}

void showLoader(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: isDarkMode
            ? theme.colorScheme.secondary
            : theme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingAnimationWidget.stretchedDots(
                color: isDarkMode
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.secondary,
                size: 50,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showModalDialog(BuildContext context, Widget child) => showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionBuilder: (context, a1, a2, child) => Transform.scale(
        scale: Curves.easeInOut.transform(a1.value),
        child: child,
      ),
      transitionDuration: const Duration(milliseconds: 500),
    );
