import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proxy_layout/proxy_layout.dart';

void main() {
  Widget makeTestableWidget({required Widget child, required Size size}) {
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

  testWidgets('LayoutProxy tablet proxy', (WidgetTester tester) async {
    final mobilePortrait = (context) => Directionality(textDirection: TextDirection.ltr, child: Text('mobile portrait'));
    final tabletPortrait = (context) => Directionality(textDirection: TextDirection.ltr, child: Text('tablet portrait'));
    final mobileLandscape = (context) => Directionality(textDirection: TextDirection.ltr, child: Text('mobile landscape'));
    final tabletLandscape = (context) => Directionality(textDirection: TextDirection.ltr, child: Text('tablet landscape'));
    final orientation = makeTestableWidget(
      size: Size(1024, 768),
      child: LayoutProxy(
        tabletPortraitBuilder: tabletPortrait,
        mobilePortraitBuilder: mobilePortrait,
        tabletLandscapeBuilder: tabletLandscape,
        mobileLandscapeBuilder: mobileLandscape,
      ),
    );

    await tester.pumpWidget(orientation);

    expect(find.text('tablet landscape'), findsOneWidget);
    expect(find.text('tablet portrait'), findsNothing);

    final orientation2 = makeTestableWidget(
      size: Size(768, 1024),
      child: LayoutProxy(
        tabletPortraitBuilder: tabletPortrait,
        mobilePortraitBuilder: mobilePortrait,
        tabletLandscapeBuilder: tabletLandscape,
        mobileLandscapeBuilder: mobileLandscape,
      ),
    );

    await tester.pumpWidget(orientation2);

    expect(find.text('tablet landscape'), findsNothing);
    expect(find.text('tablet portrait'), findsOneWidget);
  });

  testWidgets('LayoutProxy mobile proxy', (WidgetTester tester) async {
    final mobilePortrait = (context) => Directionality(textDirection: TextDirection.ltr, child: Text('mobile portrait'));
    final tabletPortrait = (context) => Directionality(textDirection: TextDirection.ltr, child: Text('tablet portrait'));
    final mobileLandscape = (context) => Directionality(textDirection: TextDirection.ltr, child: Text('mobile landscape'));
    final tabletLandscape = (context) => Directionality(textDirection: TextDirection.ltr, child: Text('tablet landscape'));
    final orientation = makeTestableWidget(
      size: Size(812, 375),
      child: LayoutProxy(
        tabletPortraitBuilder: tabletPortrait,
        mobilePortraitBuilder: mobilePortrait,
        tabletLandscapeBuilder: tabletLandscape,
        mobileLandscapeBuilder: mobileLandscape,
      ),
    );

    await tester.pumpWidget(orientation);

    expect(find.text('mobile landscape'), findsOneWidget);
    expect(find.text('mobile portrait'), findsNothing);

    final orientation2 = makeTestableWidget(
      size: Size(375, 812),
      child: LayoutProxy(
        tabletPortraitBuilder: tabletPortrait,
        mobilePortraitBuilder: mobilePortrait,
        tabletLandscapeBuilder: tabletLandscape,
        mobileLandscapeBuilder: mobileLandscape,
      ),
    );

    await tester.pumpWidget(orientation2);

    expect(find.text('mobile landscape'), findsNothing);
    expect(find.text('mobile portrait'), findsOneWidget);
  });
}
