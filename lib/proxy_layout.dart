library proxy_layout;

import 'package:flutter/material.dart';

const _defaultThreshold = 600;

enum DeviceProxyType { mobile, tablet }

enum DeviceOrientationType { portrait, landscape }

/// A Widget to select the widget to use depending on device's orientation.
class OrientationProxy extends StatelessWidget {
  final WidgetBuilder? landscapeBuilder;
  final WidgetBuilder? portraitBuilder;
  final Widget Function(BuildContext, DeviceOrientationType)? builder;

  const OrientationProxy({
    Key? key,
    required WidgetBuilder landscapeBuilder,
    required WidgetBuilder portraitBuilder,
  })   : builder = null,
        landscapeBuilder = landscapeBuilder,
        portraitBuilder = portraitBuilder,
        super(key: key);

  const OrientationProxy.generic(
      {Key? key,
      required Widget Function(BuildContext, DeviceOrientationType) builder})
      : landscapeBuilder = null,
        portraitBuilder = null,
        builder = builder,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    if (builder != null) {
      return builder!(
          context,
          orientation == Orientation.landscape
              ? DeviceOrientationType.landscape
              : DeviceOrientationType.portrait);
    }

    switch (orientation) {
      case Orientation.landscape:
        return landscapeBuilder!(context);
      case Orientation.portrait:
        return portraitBuilder!(context);
      default:
        print('Unknown orientation used $orientation, fallback to portrait');
    }
    return portraitBuilder!(context);
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
  final WidgetBuilder? tabletBuilder;
  final WidgetBuilder? mobileBuilder;
  final Widget Function(BuildContext context, DeviceProxyType type)? builder;
  final int threshold;

  const DeviceProxy({
    Key? key,
    required WidgetBuilder tabletBuilder,
    required WidgetBuilder mobileBuilder,
    this.threshold = _defaultThreshold,
  })  : tabletBuilder = tabletBuilder,
        mobileBuilder = mobileBuilder,
        builder = null,
        super(key: key);

  const DeviceProxy.generic(
      {Key? key,
      this.threshold = _defaultThreshold,
      required Widget Function(BuildContext context, DeviceProxyType type)
          builder})
      : builder = builder,
        tabletBuilder = null,
        mobileBuilder = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      final type = getType(context, orientation);

      if (builder != null) {
        return builder!(context, type);
      }

      if (type == DeviceProxyType.tablet) {
        return tabletBuilder!(context);
      } else {
        return mobileBuilder!(context);
      }
    });
  }

  DeviceProxyType getType(BuildContext context, Orientation orientation) {
    final size = MediaQuery.of(context).size.shortestSide;
    return size > threshold ? DeviceProxyType.tablet : DeviceProxyType.mobile;
  }

  static bool isMobile(BuildContext context,
      {int threshold = _defaultThreshold}) {
    final size = MediaQuery.of(context).size.shortestSide;
    return size <= threshold;
  }

  static bool isTablet(BuildContext context,
      {int threshold = _defaultThreshold}) {
    final size = MediaQuery.of(context).size.shortestSide;
    return size > threshold;
  }
}

class LayoutProxy extends StatelessWidget {
  final WidgetBuilder tabletPortraitBuilder;
  final WidgetBuilder tabletLandscapeBuilder;
  final WidgetBuilder mobilePortraitBuilder;
  final WidgetBuilder mobileLandscapeBuilder;
  final int threshold;

  const LayoutProxy({
    Key? key,
    required this.tabletPortraitBuilder,
    required this.tabletLandscapeBuilder,
    required this.mobilePortraitBuilder,
    required this.mobileLandscapeBuilder,
    this.threshold = _defaultThreshold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DeviceProxy(
      threshold: threshold,
      mobileBuilder: (context) => OrientationProxy(
        portraitBuilder: mobilePortraitBuilder,
        landscapeBuilder: mobileLandscapeBuilder,
      ),
      tabletBuilder: (context) => OrientationProxy(
        portraitBuilder: tabletPortraitBuilder,
        landscapeBuilder: tabletLandscapeBuilder,
      ),
    );
  }
}
