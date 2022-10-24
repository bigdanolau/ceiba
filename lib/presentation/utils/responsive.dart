// @packages

// Dart imports:
import 'dart:math' as math;

// Flutter imports:
import 'package:flutter/widgets.dart';

class ResponsiveDimensions {
  final double widthDevice;
  final double heightDevice;
  final double inchDevice;
  final double deviceRatio;

  ResponsiveDimensions({
    required this.widthDevice,
    required this.heightDevice,
    required this.inchDevice,
    required this.deviceRatio,
  });

  factory ResponsiveDimensions.of(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final screenSizeData = mediaQueryData.size;
    final screenInchData = math.sqrt(
        math.pow(screenSizeData.width, 2) + math.pow(screenSizeData.height, 2));
    return ResponsiveDimensions(
      widthDevice: screenSizeData.width,
      heightDevice: screenSizeData.height,
      inchDevice: screenInchData,
      deviceRatio: screenSizeData.width / screenSizeData.height,
    );
  }

  double wp(double percentSize) {
    return widthDevice * percentSize / 100;
  }

  double hp(double percentSize) {
    return heightDevice * percentSize / 100;
  }

  double ip(double percentSize) {
    return inchDevice * percentSize / 100;
  }
}
