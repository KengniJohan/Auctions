import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:auctions/models/auction.dart';
import 'package:auctions/views/widgets/user_auction_tile.dart';
import 'package:auctions/views/widgets/warning_message.dart';
import 'package:flutter/material.dart';

class AuctionGridView extends StatefulWidget {
  final List<Auction> auctions;
  const AuctionGridView({super.key, required this.auctions});

  @override
  State<AuctionGridView> createState() => _AuctionGridViewState();
}

class _AuctionGridViewState extends State<AuctionGridView> {
  @override
  Widget build(BuildContext context) {
    widget.auctions.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return widget.auctions.isEmpty
        ? const WarningMessage(message: "Aucune enchère trouvée !")
        : GridView.builder(
            itemCount: widget.auctions.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: AppResources.sizes.size024,
              mainAxisSpacing: AppResources.sizes.size012,
              mainAxisExtent: AppResources.sizes.size128,
            ),
            itemBuilder: (context, index) {
              final auction = widget.auctions[index];
              return UserAuctionTile(
                title: auction.title!,
                dateTime: auction.startDate!,
              );
            },
          );
  }
}
