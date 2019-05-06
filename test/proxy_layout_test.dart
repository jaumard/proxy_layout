import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proxy_layout/proxy_layout.dart';

void main() {
  Widget makeTestableWidget({Widget child, Size size}) {
    return MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(size: size),
        child: child,
      ),
    );
  }

  testWidgets('OrientationProxy portrait proxy', (WidgetTester tester) async {
    final portrait = (context) => Directionality(textDirection: TextDirection.ltr, child: Text('portrait'));
    final landscape = (context) => Directionality(textDirection: TextDirection.ltr, child: Text('landscape'));
    final orientation = makeTestableWidget(
      size: Size(375, 812),
      child: OrientationProxy(portraitBuilder: portrait, landscapeBuilder: landscape),
    );

    await tester.pumpWidget(orientation);

    expect(find.text('portrait'), findsOneWidget);
    expect(find.text('landscape'), findsNothing);
  });

  testWidgets('OrientationProxy landscape proxy', (WidgetTester tester) async {
    final portrait = (context) => Directionality(textDirection: TextDirection.ltr, child: Text('portrait'));
    final landscape = (context) => Directionality(textDirection: TextDirection.ltr, child: Text('landscape'));
    final orientation = makeTestableWidget(
      size: Size(1024, 768),
      child: OrientationProxy(portraitBuilder: portrait, landscapeBuilder: landscape),
    );

    await tester.pumpWidget(orientation);

    expect(find.text('portrait'), findsNothing);
    expect(find.text('landscape'), findsOneWidget);
  });

  testWidgets('DeviceProxy mobile proxy', (WidgetTester tester) async {
    final mobile = (context) => Directionality(textDirection: TextDirection.ltr, child: Text('mobile'));
    final tablet = (context) => Directionality(textDirection: TextDirection.ltr, child: Text('tablet'));
    final orientation = makeTestableWidget(
      size: Size(375, 812),
      child: DeviceProxy(tabletBuilder: tablet, mobileBuilder: mobile),
    );

    await tester.pumpWidget(orientation);

    expect(find.text('mobile'), findsOneWidget);
    expect(find.text('tablet'), findsNothing);
  });

  testWidgets('DeviceProxy tablet proxy', (WidgetTester tester) async {
    final mobile = (context) => Directionality(textDirection: TextDirection.ltr, child: Text('mobile'));
    final tablet = (context) => Directionality(textDirection: TextDirection.ltr, child: Text('tablet'));
    final orientation = makeTestableWidget(
      size: Size(1024, 768),
      child: DeviceProxy(tabletBuilder: tablet, mobileBuilder: mobile),
    );

    await tester.pumpWidget(orientation);

    expect(find.text('mobile'), findsNothing);
    expect(find.text('tablet'), findsOneWidget);
  });
}
