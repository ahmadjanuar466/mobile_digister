import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/basic/main/main_screen.dart';
import 'package:digister/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Buttons extends StatelessWidget {
  const Buttons({
    super.key,
    required this.isInfo,
    required this.isValid,
    required this.unConfirmed,
    required this.onRepeat,
    required this.onValidate,
  });

  final bool isInfo;
  final int isValid;
  final bool unConfirmed;
  final void Function() onRepeat;
  final void Function() onValidate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 10,
      ),
      child: Row(
        children: [
          if (!isInfo && unConfirmed)
            Expanded(
              child: SizedBox(
                height: 45,
                child: OutlinedButton(
                  onPressed: onRepeat,
                  child: const Text('Ulangi'),
                ),
              ),
            ),
          if (isInfo &&
              (userLevel.userLevelName == 'Bendahara' ||
                  userLevel.userLevelName == 'Admin') &&
              isValid == 0)
            Expanded(
              child: SizedBox(
                height: 45,
                child: OutlinedButton(
                  onPressed: onValidate,
                  child: const Text('Validasi'),
                ),
              ),
            ),
          const SizedBox(width: 5),
          Expanded(
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                onPressed: () => isInfo || unConfirmed
                    ? RouteHelper.pop(context)
                    : RouteHelper.pushAndRemoveUntil(
                        context,
                        widget: const MainScreen(),
                        transitionType: PageTransitionType.leftToRight,
                      ),
                child: Text(
                  isInfo || unConfirmed ? 'Kembali' : 'Selesai',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
