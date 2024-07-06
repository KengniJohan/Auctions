import 'package:auctions/configs/ressources/app_ressources.dart';
import 'package:flutter/material.dart';

class AuctionTitle extends StatelessWidget {
  final String title;
  const AuctionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: AppResources.colors.secondary,
        fontSize: AppResources.sizes.size036,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none,
      ),
    );
  }
}
