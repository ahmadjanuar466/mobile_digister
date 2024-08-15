import 'package:digister/models/user_level_model.dart';
import 'package:digister/models/user_model.dart';
import 'package:digister/themes/custom_theme.dart';
import 'package:digister/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import '../models/forgot_password_model.dart';

ThemeData theme = CustomTheme.lightTheme;
bool isDarkMode = false;
int isFirst = int.tryParse(localStorage.getItem('isFirst') ?? "") ?? 1;
late User user;
late UserLevel userLevel;
List<dynamic> listSecurity = [];
final ForgotPassword forgotPasswordModel = ForgotPassword();

void showInSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: theme.textTheme.titleSmall,
      textAlign: TextAlign.justify,
    ),
  ));
}

String? validator(String? value) {
  if (value!.isEmpty || value == "") {
    return 'Wajib diisi';
  }

  return null;
}

void showLoader(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => PopScope(
      canPop: false,
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 100.h),
        backgroundColor: theme.colorScheme.primaryContainer,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.h)),
        child: Container(
          padding: EdgeInsets.all(12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.h),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 25.h,
                height: 25.v,
                child: const CircularProgressIndicator(),
              ),
              SizedBox(width: 10.h),
              Text(
                'Loading',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void showModalDialog(BuildContext context, Widget child) => showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionBuilder: (context, a1, a2, child) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;

        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 30, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 250),
    );
