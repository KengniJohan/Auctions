import 'package:flutter/material.dart';

class AppResources {
  static var colors = _Colors();
  static var sizes = _Sizes();
  static var radius = _Radius();
  static var assetImages = _AssetImages();
}

class _Colors {
  final primary = const Color(0XFF24445C);
  final secondary = const Color(0XFF56739A);
  final darkGrey = const Color(0XFF929292);
  final grey = const Color(0XFFD9D9D9);
}

class _Sizes {
  final size002 = 2.0;
  final size008 = 8.0;
  final size016 = 16.0;
  final size018 = 18.0;
  final size024 = 24.0;
  final size032 = 32.0;
  final size036 = 36.0;
  final size048 = 48.0;
  final size064 = 64.0;
}

class _Radius {
  final radius10 = BorderRadius.circular(10);
}

class _AssetImages {}
