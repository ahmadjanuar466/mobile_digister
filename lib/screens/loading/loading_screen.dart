import 'package:digister/models/dues_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/loading/components/buttons.dart';
import 'package:digister/screens/loading/components/dues_detail.dart';
import 'package:digister/services/dues.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/utils/lottie_asset.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({
    super.key,
    required this.dues,
    this.isInfo = false,
    this.fromNotification = false,
  });

  final Dues dues;
  final bool isInfo;
  final bool fromNotification;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _loading = false;
  String _lottieAsset = LottieAssets.info;
  bool _unConfirmed = true;

  @override
  void initState() {
    super.initState();
    if (!widget.isInfo) {
      _sendConfirmation();
    }
  }

  void _sendConfirmation() async {
    setState(() {
      _loading = true;
      _lottieAsset = LottieAssets.loading;
    });

    final confirmation = await confirmDues(widget.dues.toMap());

    setState(() {
      _loading = false;
    });

    if (confirmation) {
      setState(() {
        _lottieAsset = LottieAssets.success;
        _unConfirmed = false;
      });
      return;
    }

    setState(() {
      _lottieAsset = LottieAssets.error;
    });
  }

  void _handleValidation() async {
    setState(() {
      _loading = true;
      _lottieAsset = LottieAssets.loading;
    });

    final validated = await validateDues(widget.dues.toMapValidate());

    setState(() {
      _loading = false;
    });

    if (validated) {
      setState(() {
        _lottieAsset = LottieAssets.success;
      });
      return;
    }

    setState(() {
      _lottieAsset = LottieAssets.error;
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: !isDarkMode ? Colors.grey.shade100 : null,
      body: PopScope(
        canPop: !widget.fromNotification,
        onPopInvoked: (didPop) {
          if (didPop) return;

          RouteHelper.pop(context);
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              DuesDetail(dues: widget.dues, isInfo: widget.isInfo),
              Positioned(
                top: _loading ? 150 : 120,
                child: Lottie.asset(
                  _lottieAsset,
                  width: _loading
                      ? 150
                      : _lottieAsset == LottieAssets.error
                          ? 220
                          : 185,
                  repeat: _loading,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Buttons(
                  isInfo: widget.isInfo,
                  unConfirmed: _unConfirmed,
                  isValid: widget.dues.isValid!,
                  onRepeat: _sendConfirmation,
                  onValidate: _handleValidation,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
