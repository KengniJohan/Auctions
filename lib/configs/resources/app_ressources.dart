import 'package:flutter/material.dart';

class AppResources {
  static var colors = _Colors();
  static var sizes = _Sizes();
  static var radius = _Radius();
  static var assetImages = _AssetImages();
}

class _Colors {
  final primary = const Color(0XFF24445C);
  final selectedPrimary = const Color(0XFF1E394D);
  final secondary = const Color(0XFF56739A);
  final darkGrey = const Color(0XFF929292);
  final grey = const Color(0XFFD9D9D9);
}

class _Sizes {
  final size000 = 0.0;
  final size002 = 2.0;
  final size008 = 8.0;
  final size012 = 12.0;
  final size016 = 16.0;
  final size018 = 18.0;
  final size024 = 24.0;
  final size028 = 28.0;
  final size032 = 32.0;
  final size034 = 34.0;
  final size036 = 36.0;
  final size048 = 48.0;
  final size064 = 64.0;
  final size072 = 72.0;
  final size080 = 80.0;
  final size096 = 96.0;
  final size104 = 104.0;
  final size112 = 112.0;
  final size120 = 120.0;
  final size128 = 128.0;
  final size160 = 160.0;
  final size200 = 200.0;
  final size320 = 320.0;
  final size340 = 340.0;
  final size360 = 360.0;
  final size380 = 380.0;
  final size400 = 400.0;
}

class _Radius {
  final radius10 = BorderRadius.circular(10);
  final radius24 = BorderRadius.circular(24);
}

class _AssetImages {}
