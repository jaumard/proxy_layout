# proxy_layout

[![pub package](https://img.shields.io/pub/v/proxy_layout.svg)](https://pub.dartlang.org/packages/proxy_layout)

Package to select layout per orientation or device size like mobile vs tablet layouts or portrait vs landscape

## Usage

You have two widgets at your disposal, `DeviceProxy` to use different widget for mobile and tablet devices, `OrientationProxy` to use different device depending of the device orientation.

### DeviceProxy

```dart
DeviceProxy(
        mobile: Text('Mobile widget'),
        tablet: Text('Tablet widget'),
      ),
```

The threshold to separate Mobile and Tablet devices is 600, you can override it by setting the `threshold` attribute.

### OrientationProxy

```dart
OrientationProxy(
          landscape: Text('Landscape widget'),
          portrait: Text('Portrait widget'),
        ),
```
