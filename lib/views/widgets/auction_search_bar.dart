import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:flutter/material.dart';

class AuctionSearchBar extends StatefulWidget {
  final void Function(String) onChanged;
  const AuctionSearchBar({super.key, required this.onChanged});

  @override
  State<AuctionSearchBar> createState() => _AuctionSearchBarState();
}

class _AuctionSearchBarState extends State<AuctionSearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppResources.colors.primary,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(AppResources.sizes.size008),
        hintText: "Rechercher...",
        hintStyle: TextStyle(color: AppResources.colors.darkGrey),
        prefixIcon: Icon(Icons.search, color: AppResources.colors.darkGrey),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppResources.colors.darkGrey,
          ),
          borderRadius: AppResources.radius.radius10,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: AppResources.sizes.size002,
            color: AppResources.colors.secondary,
          ),
          borderRadius: AppResources.radius.radius10,
        ),
      ),
      onChanged: widget.onChanged,
    );
  }
}
