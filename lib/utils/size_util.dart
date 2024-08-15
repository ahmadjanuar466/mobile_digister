// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

// These are used in the code as a reference to create your UI Responsively.
const num WIDTH = 360;
const num HEIGHT = 800;
const num STATUS_BAR = 0;
typedef ResponsiveBuild = Widget Function(
  BuildContext context,
  Orientation orientation,
  DeviceType deviceType,
);

class Sizer extends StatelessWidget {
  const Sizer({
    super.key,
    required this.builder,
  });

  /// Builds the widget whenever the orientation changes.
  final ResponsiveBuild builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeUtils.setScreenSize(constraints, orientation);
        return builder(context, orientation, SizeUtils.deviceType);
      });
    });
  }
}

class SizeUtils {
  /// Device's BoxConstraints
  static late BoxConstraints boxConstraints;

  /// Device's Orientation
  static late Orientation orientation;

  /// Type of Device
  ///
  /// This can either be mobile or tablet
  static late DeviceType deviceType;

  /// Device's Height
  static late double height;

  /// Device's Width
  static late double width;

  static void setScreenSize(
    BoxConstraints constraints,
    Orientation currentOrientation,
  ) {
    // Sets boxConstraints and orientation
    boxConstraints = constraints;
    orientation = currentOrientation;

    // Sets screen width and height
    if (orientation == Orientation.portrait) {
      width = boxConstraints.maxWidth.isNonZero(defaultValue: WIDTH);
      height = boxConstraints.maxHeight.isNonZero();
    } else {
      width = boxConstraints.maxWidth.isNonZero(defaultValue: WIDTH);
      height = boxConstraints.maxHeight.isNonZero();
    }
    deviceType = DeviceType.mobile;
  }
}

/// This extension is used to set padding/margin (for the top and bottom side) &
/// height of the screen or widget according to the Viewport height.
extension ResponsiveExtension on num {
  /// This method is used to get device viewport width.
  double get _width => SizeUtils.width;

  /// This method is used to get device viewport height.
  double get _height => SizeUtils.height;

  /// This method is used to set padding/margin (for the left and Right side) &
  /// width of the screen or widget according to the Viewport width.
  double get h => ((this * _width) / WIDTH);

  /// This method is used to set padding/margin (for the top and bottom side) &
  /// height of the screen or widget according to the Viewport height.
  double get v => (this * _height) / (HEIGHT - STATUS_BAR);

  /// This method is used to set smallest px in image height and width
  double get adaptSize {
    var height = v;
    var width = h;
    return height < width ? height.toDoubleValue() : width.toDoubleValue();
  }

  /// This method is used to set text font size according to Viewport
  double get fSize => adaptSize;
}

extension FormatExtension on double {
  /// Return a [double] value with formatted according to provided fractionDigits
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(toStringAsFixed(fractionDigits));
  }

  double isNonZero({num defaultValue = 0.0}) {
    return this > 0 ? this : defaultValue.toDouble();
  }
}

enum DeviceType { mobile, tablet, desktop }
