import 'package:digister/models/cctv_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/cctv/detail_cctv_screen.dart';
import 'package:digister/screens/main/main_screen.dart';
import 'package:digister/services/housing.dart';
import 'package:digister/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:page_transition/page_transition.dart';

class CCTVScreen extends StatefulWidget {
  const CCTVScreen({super.key, required this.canPop});

  final bool canPop;

  @override
  State<CCTVScreen> createState() => _CCTVScreenState();
}

class _CCTVScreenState extends State<CCTVScreen> {
  final List<VlcPlayerController> _controller = [];
  final List<CCTV> _cctvs = [];

  @override
  void initState() {
    super.initState();
    _getCCTV();
  }

  @override
  Future<void> dispose() async {
    for (var controller in _controller) {
      controller.stopRendererScanning();
      controller.dispose();
    }
    super.dispose();
  }

  void _getCCTV() async {
    final cctvs = await getCCTV(user.block);

    for (var cctv in cctvs) {
      if (cctv.isActive == 1) {
        _controller.add(VlcPlayerController.network(
          cctv.url,
          allowBackgroundPlayback: true,
          hwAcc: HwAcc.full,
          options: VlcPlayerOptions(
            advanced: VlcAdvancedOptions([
              VlcAdvancedOptions.networkCaching(2000),
            ]),
            rtp: VlcRtpOptions([
              VlcRtpOptions.rtpOverRtsp(true),
            ]),
          ),
        ));
      }
    }

    setState(() {
      _controller;
      _cctvs.addAll(cctvs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => RouteHelper.pushAndRemoveUntil(
            context,
            widget: const MainScreen(),
            transitionType: PageTransitionType.leftToRight,
          ),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(
          "CCTV blok ${user.block}",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: PopScope(
        canPop: widget.canPop,
        onPopInvoked: (didPop) {
          if (didPop) return;

          RouteHelper.pushAndRemoveUntil(
            context,
            widget: const MainScreen(),
            transitionType: PageTransitionType.leftToRight,
          );
        },
        child: _controller.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _controller.length,
                      (index) => Container(
                        width: double.maxFinite,
                        height: 200,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: InkWell(
                          onTap: () => RouteHelper.pushReplacement(
                            context,
                            widget: DetailCCTVScreen(url: _cctvs[index].url),
                            transitionType: PageTransitionType.bottomToTop,
                          ),
                          child: VlcPlayer(
                            controller: _controller[index],
                            aspectRatio: 16 / 9,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
