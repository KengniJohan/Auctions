import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:flutter/material.dart';

class AuctionTitle extends StatelessWidget {
  final String title;
  final Color color;
  final double? fontSize;
  const AuctionTitle({
    super.key,
    required this.title,
    required this.color,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: fontSize ?? AppResources.sizes.size036,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none,
      ),
    );
  }
}
