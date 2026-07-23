import 'package:digister/models/cctv_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/basic/cctv/detail_cctv_screen.dart';
import 'package:digister/services/housing.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CCTVScreen extends StatefulWidget {
  const CCTVScreen({super.key});

  @override
  State<CCTVScreen> createState() => _CCTVScreenState();
}

class _CCTVScreenState extends State<CCTVScreen> {
  final List<CCTV> _cctvs = [];

  @override
  void initState() {
    super.initState();
    _getCCTV();
  }

  void _getCCTV() async {
    final cctvs = await getCCTV("");

    for (var cctv in cctvs) {
      if (cctv.isActive == 1) {
        _cctvs.add(cctv);
      }
    }

    setState(() {
      _cctvs;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_cctvs.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SafeArea(
      child: ListView(
        padding: EdgeInsets.all(16.h),
        children: [
          Text(
            'CCTV',
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 10.v),
          ..._cctvs.map(
            (cctv) => ListTile(
              title: Text('Blok ${cctv.blockName}'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => RouteHelper.pushReplacement(
                context,
                widget: DetailCCTVScreen(url: cctv.url, security: true),
                transitionType: PageTransitionType.bottomToTop,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
