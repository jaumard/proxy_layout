import 'package:flutter/material.dart';
import 'package:proxy_layout/proxy_layout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proxy Layout Home Page'),
      ),
      body: DeviceProxy(
        mobileBuilder: (_) => OrientationProxy(
          landscapeBuilder: (_) => MyMobileLandscapeContent(),
          portraitBuilder: (_) => MyMobilePortraitContent(),
        ),
        tabletBuilder: (_) => OrientationProxy(
          landscapeBuilder: (_) => MyTabletLandscapeContent(),
          portraitBuilder: (_) => MyTabletPortraitContent(),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyMobilePortraitContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Mobile portrait content'));
  }
}

class MyMobileLandscapeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Mobile landscape content'));
  }
}

class MyTabletPortraitContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Tablet portrait content'));
  }
}

class MyTabletLandscapeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Tablet landscape content'));
  }
}
