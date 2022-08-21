import 'package:flutter/material.dart';

const double hPadding = 20;
const double vPadding = 20;

extension DimsExtensionOld on BuildContext {
  Orientation get deviceOrientation => MediaQuery.of(this).orientation;
  bool get isLandscape => deviceOrientation == Orientation.landscape;
  bool get isPortrait => deviceOrientation == Orientation.portrait;
}

class XBox extends StatelessWidget {
  const XBox(
    this._width, {
    Key? key,
  }) : super(key: key);

  final double _width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
    );
  }
}

class YBox extends StatelessWidget {
  const YBox(
    this._height, {
    Key? key,
  }) : super(key: key);

  final double _height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
    );
  }
}
