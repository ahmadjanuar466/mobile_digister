import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/cctv/cctv_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:page_transition/page_transition.dart';

class DetailCCTVScreen extends StatefulWidget {
  const DetailCCTVScreen({super.key, required this.url});

  final String url;

  @override
  State<DetailCCTVScreen> createState() => _DetailCCTVScreenState();
}

class _DetailCCTVScreenState extends State<DetailCCTVScreen>
    with SingleTickerProviderStateMixin {
  VlcPlayerController? _controller;
  late TransformationController _transformationController;
  late AnimationController _animationController;
  Animation<Matrix4>? _animation;
  TapDownDetails? _tapDownDetails;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        _transformationController.value = _animation!.value;
      });

    _controller = VlcPlayerController.network(
      widget.url,
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
    );
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _animationController.dispose();
    _controller?.stopRendererScanning();
    _controller?.dispose();
    super.dispose();
  }

  void _scaleCCTV() {
    final position = _tapDownDetails!.localPosition;

    const double scale = 3;
    final x = -position.dx * (scale - 1);
    final y = -position.dy * (scale - 1);
    final zoomed = Matrix4.identity()
      ..translate(x, y)
      ..scale(scale);

    final value = _transformationController.value.isIdentity()
        ? zoomed
        : Matrix4.identity();

    _animation = Matrix4Tween(
      begin: _transformationController.value,
      end: value,
    ).animate(
      CurveTween(curve: Curves.easeOut).animate(_animationController),
    );

    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => RouteHelper.pushReplacement(
            context,
            widget: const CCTVScreen(canPop: false),
            transitionType: PageTransitionType.topToBottom,
          ),
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;

          RouteHelper.pushReplacement(
            context,
            widget: const CCTVScreen(canPop: false),
            transitionType: PageTransitionType.topToBottom,
          );
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: _controller != null
              ? GestureDetector(
                  onDoubleTapDown: (details) => _tapDownDetails = details,
                  onDoubleTap: _scaleCCTV,
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    clipBehavior: Clip.none,
                    minScale: 1,
                    maxScale: 5,
                    child: VlcPlayer(
                      controller: _controller!,
                      aspectRatio: 16 / 9,
                      placeholder: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
