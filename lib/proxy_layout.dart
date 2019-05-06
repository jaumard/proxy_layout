library proxy_layout;

import 'package:flutter/material.dart';

enum DeviceProxyType { mobile, tablet }

enum DeviceOrientationType { portrait, landscape }

/// A Widget to select the widget to use depending on device's orientation.
class OrientationProxy extends StatelessWidget {
  final WidgetBuilder landscapeBuilder;
  final WidgetBuilder portraitBuilder;
  final Widget Function(BuildContext, DeviceOrientationType) builder;

  const OrientationProxy({Key key, this.landscapeBuilder, this.portraitBuilder, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    if (builder != null) {
      return builder(context, orientation == Orientation.landscape ? DeviceOrientationType.landscape : DeviceOrientationType.portrait);
    }

    switch (orientation) {
      case Orientation.landscape:
        return landscapeBuilder(context);
      case Orientation.portrait:
        return portraitBuilder(context);
      default:
        print('Unknown orientation used $orientation, fallback to portrait');
    }
    return portraitBuilder(context);
  }

  static bool isPortrait(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait;
  }

  static bool isLandscape(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.landscape;
  }
}

/// A Widget to select the widget to use depending on device's width.
class DeviceProxy extends StatelessWidget {
  final WidgetBuilder tabletBuilder;
  final WidgetBuilder mobileBuilder;
  final Widget Function(BuildContext context, DeviceProxyType type) builder;
  final int threshold;

  const DeviceProxy({Key key, this.tabletBuilder, this.mobileBuilder, this.threshold = 600, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      final type = getType(context);

      if (builder != null) {
        return builder(context, type);
      }

      if (type == DeviceProxyType.tablet) {
        return tabletBuilder(context);
      } else {
        return mobileBuilder(context);
      }
    });
  }

  DeviceProxyType getType(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width > size.height ? size.height : size.width;
    return width > threshold ? DeviceProxyType.tablet : DeviceProxyType.mobile;
  }

  static bool isMobile(BuildContext context, {int threshold = 600}) {
    Size size = MediaQuery.of(context).size;
    double width = size.width > size.height ? size.height : size.width;
    return width <= threshold;
  }

  static bool isTablet(BuildContext context, {int threshold = 600}) {
    Size size = MediaQuery.of(context).size;
    double width = size.width > size.height ? size.height : size.width;
    return width > threshold;
  }
}
