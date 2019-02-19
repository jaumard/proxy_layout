library proxy_layout;

import 'package:flutter/material.dart';

/// A Widget to select the widget to use depending on device's orientation.
class OrientationProxy extends StatelessWidget {
  final Widget landscape;
  final Widget portrait;

  const OrientationProxy({Key key, this.landscape, this.portrait}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    switch (orientation) {
      case Orientation.landscape:
        return landscape;
      case Orientation.portrait:
        return portrait;
      default:
        print('Unknown orientation used $orientation, fallback to portrait');
    }
    return portrait;
  }
}

/// A Widget to select the widget to use depending on device's width.
class DeviceProxy extends StatelessWidget {
  final Widget tablet;
  final Widget mobile;
  final int threshold;

  const DeviceProxy({Key key, this.tablet, this.mobile, this.threshold = 600}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      Size size = MediaQuery.of(context).size;
      double width = size.width > size.height ? size.height : size.width;

      if (width > threshold) {
        return tablet;
      } else {
        return mobile;
      }
    });
  }
}
