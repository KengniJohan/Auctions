import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:flutter/material.dart';

class AuctionNavChip extends StatelessWidget {
  final String title;
  final bool selected;
  final void Function(bool) onSelected;
  const AuctionNavChip({
    super.key,
    required this.title,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: SizedBox(
        width: double.maxFinite,
        child: Text(title),
      ),
      labelPadding: EdgeInsets.only(
        left: AppResources.sizes.size036,
        top: AppResources.sizes.size016,
        right: AppResources.sizes.size024,
        bottom: AppResources.sizes.size016,
      ),
      labelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: AppResources.sizes.size018,
      ),
      pressElevation: 0,
      selected: selected,
      color: MaterialStatePropertyAll(
        selected
            ? AppResources.colors.selectedPrimary
            : AppResources.colors.primary,
      ),
      backgroundColor: AppResources.colors.primary,
      side: BorderSide(width: 0, color: AppResources.colors.primary),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      showCheckmark: false,
      onSelected: onSelected,
    );
  }
}
