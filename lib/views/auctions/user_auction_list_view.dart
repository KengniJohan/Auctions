import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:auctions/controllers/controllers.dart';
import 'package:auctions/models/auction.dart';
import 'package:auctions/models/enums/auction_status.dart';
import 'package:auctions/views/widgets/auction_grid_view.dart';
import 'package:auctions/views/widgets/auction_search_bar.dart';
import 'package:auctions/views/widgets/auction_submit_btn.dart';
import 'package:auctions/views/widgets/warning_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserAuctionListView extends StatefulWidget {
  final void Function() onCreatingNewAuction;
  const UserAuctionListView({super.key, required this.onCreatingNewAuction});

  @override
  State<UserAuctionListView> createState() => _UserAuctionListViewState();
}

class _UserAuctionListViewState extends State<UserAuctionListView>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  String _searchKey = "";

  List<Auction> _filteredAuctions(List<Auction> auctions) => auctions
      .where((auction) =>
          auction.title!.toLowerCase().contains(_searchKey.toLowerCase()))
      .toList();

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: AppResources.sizes.size032),
          child: Row(
            children: [
              Flexible(
                flex: 40,
                child: AuctionSearchBar(
                  onChanged: (value) {
                    setState(() {
                      _searchKey = value;
                    });
                  },
                ),
              ),
              const Spacer(),
              FutureBuilder(
                future: userController.getLoggedUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    if (data != null) {
                      return Flexible(
                        flex: 2,
                        child: CircleAvatar(
                          foregroundColor: Colors.white,
                          backgroundColor: AppResources.colors.secondary,
                          child: Text(
                            "${data.name![0]}${data.surname![0]}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }
                  }

                  return Flexible(
                    flex: 1,
                    child: CircleAvatar(
                      foregroundColor: Colors.white,
                      backgroundColor: AppResources.colors.secondary,
                      child: const Text(
                        "I",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        AuctionSubmitBtn(
          text: "Nouvelle Enchère",
          onPressed: widget.onCreatingNewAuction,
          width: AppResources.sizes.size200,
        ),
        SizedBox(height: AppResources.sizes.size024),
        TabBar(
          controller: _tabController,
          indicatorColor: AppResources.colors.secondary,
          tabs: const [
            Tab(
              text: "Nouvelle",
            ),
            Tab(
              text: "En cours",
            ),
            Tab(
              text: "Terminée",
            ),
            Tab(
              text: "Annulée",
            ),
            Tab(
              text: "Reportée",
            ),
          ],
        ),
        Expanded(
          child: StreamBuilder(
            stream: auctionController.getAllAsStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const WarningMessage(
                    message: "Une erreur est survenue !");
              }

              if (snapshot.hasData) {
                final auctions = snapshot.data!;

                final newAuctions = auctions
                    .where((auction) => auction.status == AuctionStatus.newed)
                    .toList();
                final processingAuctions = auctions
                    .where(
                        (auction) => auction.status == AuctionStatus.inProcess)
                    .toList();
                final finishedAuctions = auctions
                    .where(
                        (auction) => auction.status == AuctionStatus.finished)
                    .toList();
                final canceledAuctions = auctions
                    .where(
                        (auction) => auction.status == AuctionStatus.canceled)
                    .toList();
                final rescheduledAuctions = auctions
                    .where((auction) =>
                        auction.status == AuctionStatus.rescheduled)
                    .toList();

                return TabBarView(
                  controller: _tabController,
                  children: [
                    AuctionGridView(auctions: _filteredAuctions(newAuctions)),
                    AuctionGridView(
                        auctions: _filteredAuctions(processingAuctions)),
                    AuctionGridView(
                        auctions: _filteredAuctions(finishedAuctions)),
                    AuctionGridView(
                        auctions: _filteredAuctions(canceledAuctions)),
                    AuctionGridView(
                        auctions: _filteredAuctions(rescheduledAuctions)),
                  ],
                );
              }

              return Center(
                child: CupertinoActivityIndicator(
                  color: AppResources.colors.primary,
                  radius: AppResources.sizes.size018,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
