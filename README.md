# proxy_layout

[![pub package](https://img.shields.io/pub/v/proxy_layout.svg)](https://pub.dartlang.org/packages/proxy_layout)

Package to select layout per orientation or device size like mobile vs tablet layouts or portrait vs landscape

## Usage

You have two widgets at your disposal, `DeviceProxy` to use different widget for mobile and tablet devices, `OrientationProxy` to use different device depending of the device orientation.

### DeviceProxy

```dart
DeviceProxy(
        mobileBuilder: (context) => Text('Mobile widget'),
        tabletBuilder: (context) => Text('Tablet widget'),
      ),
```

The threshold to separate Mobile and Tablet devices is 600, you can override it by setting the `threshold` attribute.

If you don't want to specify mobile and tablet you can use `builder` attribute that will let you know if you are on tablet or mobile with `DeviceProxyType` enum.

The is `isMobile` and `isTablet` static methods available if you need to know at some point the device type to tweak some attributes. 

### OrientationProxy

```dart
OrientationProxy(
          landscapeBuilder: (context) => Text('Landscape widget'),
          portraitBuilder: (context) => Text('Portrait widget'),
        ),
```

If you don't want to specify portrait and landscape you can use `builder` attribute that will let you know which orientation you are with `DeviceOrientationType` enum.

The is `isPortrait` and `isLandscape` static methods available if you need to know at some point the orientation to just tweak some attributes.

### LayoutProxy
LayoutProxy help you manage device and orientation at once, check this out:

```dart
LayoutProxy(
          tabletPortraitBuilder: (context) => Text('Tablet portrait widget'),
          tabletLandscapeBuilder: (context) => Text('Tablet landscape widget'),
          mobilePortraitBuilder: (context) => Text('Mobile portrait widget'),
          mobileLandscapeBuilder: (context) => Text('Mobile landscape widget'),
        ),
```

The threshold to separate Mobile and Tablet devices is 600, you can override it by setting the `threshold` attribute.
