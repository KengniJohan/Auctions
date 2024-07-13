import 'dart:typed_data';

import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:auctions/utils/helpers.dart';
import 'package:flutter/material.dart';

class PhoneListTile extends StatelessWidget {
  final Uint8List? imageData;
  final String brand;
  final String model;
  final String? os;
  final int? minPrice;
  final int? batterie;
  const PhoneListTile({
    super.key,
    this.imageData,
    required this.brand,
    required this.model,
    this.os,
    this.minPrice,
    this.batterie,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppResources.sizes.size002,
      color: Colors.white,
      shape: const BeveledRectangleBorder(),
      child: Container(
        padding: EdgeInsets.all(AppResources.sizes.size016),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  width: AppResources.sizes.size048,
                  height: AppResources.sizes.size048,
                  decoration: BoxDecoration(
                    color: imageData != null ? null : AppResources.colors.grey,
                    borderRadius: AppResources.radius.radius24,
                  ),
                  child: imageData == null ? null : Image.memory(imageData!),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  brand,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  model,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  os ?? '...',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  minPrice == null ? '...' : numberFormat.format(minPrice),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  batterie == null ? '...' : batterie.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
