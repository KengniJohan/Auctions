import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:flutter/material.dart';

class WarningMessage extends StatelessWidget {
  final String message;
  const WarningMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          color: AppResources.colors.grey,
          fontWeight: FontWeight.w500,
          fontSize: AppResources.sizes.size018,
        ),
      ),
    );
  }
}
