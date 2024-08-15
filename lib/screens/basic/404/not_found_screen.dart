import 'package:digister/routes/route_helper.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/utils/image_constants.dart';
import 'package:digister/utils/size_util.dart';
import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key, required this.isMainScreen});

  final bool isMainScreen;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageAssets.notFoundImage),
          Text(
            'Maaf, fitur ini belum tersedia',
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 10.v),
          if (!isMainScreen)
            OutlinedButton(
              onPressed: () => RouteHelper.pop(context),
              child: const Text('Kembali'),
            ),
        ],
      ),
    );
  }
}
