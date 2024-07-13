import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:auctions/controllers/controllers.dart';
import 'package:auctions/models/auction.dart';
import 'package:auctions/models/enums/auction_status.dart';
import 'package:auctions/models/user.dart';
import 'package:auctions/views/widgets/auction_search_bar.dart';
import 'package:auctions/views/widgets/main_auction_tile.dart';
import 'package:auctions/views/widgets/search_activity_indicator.dart';
import 'package:auctions/views/widgets/warning_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MainAuctionListView extends StatefulWidget {
  final void Function(Auction) onParticipating;
  const MainAuctionListView({super.key, required this.onParticipating});

  @override
  State<MainAuctionListView> createState() => _MainAuctionListViewState();
}

class _MainAuctionListViewState extends State<MainAuctionListView> {
  User? _loggedUser;
  // String _searchKey = "";

  @override
  void setState(VoidCallback fn) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final user = await userController.getLoggedUser();
      setState(() {
        _loggedUser = user;
      });
    });
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      // _searchKey = value;
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
        Expanded(
          child: StreamBuilder(
            stream: auctionController.getAllAsStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const WarningMessage(
                    message: "Une erreur s'est produite !");
              }

              if (snapshot.hasData) {
                final auctions = snapshot.data!
                    .where((auction) =>
                        auction.admin != _loggedUser?.id &&
                        (auction.status == AuctionStatus.newed ||
                            auction.status == AuctionStatus.inProcess))
                    .toList();

                auctions.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

                return auctions.isEmpty
                    ? const WarningMessage(message: "Aucune enchère trouvée !")
                    : ListView.builder(
                        itemCount: auctions.length,
                        itemBuilder: (context, index) {
                          final auction = auctions[index];
                          return Column(
                            children: [
                              SizedBox(height: AppResources.sizes.size024),
                              MainAuctionTile(
                                auction: auction,
                                onParticipating: widget.onParticipating,
                              ),
                              SizedBox(height: AppResources.sizes.size024),
                              Divider(height: AppResources.sizes.size002),
                            ],
                          );
                        },
                      );
              }

              return SearchActivityIndicator(
                radius: AppResources.sizes.size024,
              );
            },
          )
          /*SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              foregroundColor: Colors.white,
                              backgroundColor: AppResources.colors.secondary,
                              radius: AppResources.sizes.size012,
                              child: Text(
                                "KJ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppResources.sizes.size012,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: AppResources.sizes.size016,
                            ),
                            Text(
                              "publié le 08/05/2024 à 15:00",
                              style: TextStyle(
                                color: AppResources.colors.darkGrey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Statut :"),
                            SizedBox(
                              width: AppResources.sizes.size016,
                            ),
                            Text(
                              "Annulée",
                              style: TextStyle(
                                color: AppResources.colors.secondary,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: AppResources.sizes.size024),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 16,
                              child: Container(
                                height: AppResources.sizes.size160,
                                decoration: BoxDecoration(
                                  color: AppResources.colors.darkGrey,
                                  borderRadius: AppResources.radius.radius10,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: 16,
                              child: Container(
                                height: AppResources.sizes.size160,
                                decoration: BoxDecoration(
                                  color: AppResources.colors.darkGrey,
                                  borderRadius: AppResources.radius.radius10,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: 16,
                              child: Container(
                                height: AppResources.sizes.size160,
                                decoration: BoxDecoration(
                                  color: AppResources.colors.darkGrey,
                                  borderRadius: AppResources.radius.radius10,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: AppResources.sizes.size016),
                        Row(
                          children: [
                            Expanded(
                              flex: 16,
                              child: Container(
                                height: AppResources.sizes.size160,
                                decoration: BoxDecoration(
                                  color: AppResources.colors.darkGrey,
                                  borderRadius: AppResources.radius.radius10,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: 16,
                              child: Container(
                                height: AppResources.sizes.size160,
                                decoration: BoxDecoration(
                                  color: AppResources.colors.darkGrey,
                                  borderRadius: AppResources.radius.radius10,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: 16,
                              child: Container(
                                height: AppResources.sizes.size160,
                                decoration: BoxDecoration(
                                  color: AppResources.colors.darkGrey,
                                  borderRadius: AppResources.radius.radius10,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: AppResources.sizes.size024),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text("Heure d'ouverture :"),
                                SizedBox(
                                  width: AppResources.sizes.size016,
                                ),
                                Text(
                                  "15:00",
                                  style: TextStyle(
                                    color: AppResources.colors.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Date d'ouverture :"),
                                SizedBox(
                                  width: AppResources.sizes.size016,
                                ),
                                Text(
                                  "17/05/2024",
                                  style: TextStyle(
                                    color: AppResources.colors.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        AuctionSubmitBtn(
                          text: "S'inscrire",
                          onPressed: () {},
                          width: AppResources.sizes.size160,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: AppResources.sizes.size024),
                Divider(height: AppResources.sizes.size002),
                SizedBox(height: AppResources.sizes.size024),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              foregroundColor: Colors.white,
                              backgroundColor: AppResources.colors.secondary,
                              radius: AppResources.sizes.size012,
                              child: Text(
                                "KJ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppResources.sizes.size012,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: AppResources.sizes.size016,
                            ),
                            Text(
                              "publié le 08/05/2024 à 15:00",
                              style: TextStyle(
                                color: AppResources.colors.darkGrey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Statut :"),
                            SizedBox(
                              width: AppResources.sizes.size016,
                            ),
                            Text(
                              "Annulée",
                              style: TextStyle(
                                color: AppResources.colors.secondary,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: AppResources.sizes.size024),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 16,
                              child: Container(
                                height: AppResources.sizes.size160,
                                decoration: BoxDecoration(
                                  color: AppResources.colors.darkGrey,
                                  borderRadius: AppResources.radius.radius10,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: 16,
                              child: Container(
                                height: AppResources.sizes.size160,
                                decoration: BoxDecoration(
                                  color: AppResources.colors.darkGrey,
                                  borderRadius: AppResources.radius.radius10,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: 16,
                              child: Container(
                                height: AppResources.sizes.size160,
                                decoration: BoxDecoration(
                                  color: AppResources.colors.darkGrey,
                                  borderRadius: AppResources.radius.radius10,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: AppResources.sizes.size016),
                        Row(
                          children: [
                            Expanded(
                              flex: 16,
                              child: Container(
                                height: AppResources.sizes.size160,
                                decoration: BoxDecoration(
                                  color: AppResources.colors.darkGrey,
                                  borderRadius: AppResources.radius.radius10,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: 16,
                              child: Container(
                                height: AppResources.sizes.size160,
                                decoration: BoxDecoration(
                                  color: AppResources.colors.darkGrey,
                                  borderRadius: AppResources.radius.radius10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: AppResources.sizes.size024),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text("Heure d'ouverture :"),
                                SizedBox(
                                  width: AppResources.sizes.size016,
                                ),
                                Text(
                                  "15:00",
                                  style: TextStyle(
                                    color: AppResources.colors.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Date d'ouverture :"),
                                SizedBox(
                                  width: AppResources.sizes.size016,
                                ),
                                Text(
                                  "17/05/2024",
                                  style: TextStyle(
                                    color: AppResources.colors.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        AuctionSubmitBtn(
                          text: "S'inscrire",
                          onPressed: () {},
                          width: AppResources.sizes.size160,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: AppResources.sizes.size024),
                Divider(height: AppResources.sizes.size002),
                SizedBox(height: AppResources.sizes.size024),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              foregroundColor: Colors.white,
                              backgroundColor: AppResources.colors.secondary,
                              radius: AppResources.sizes.size012,
                              child: Text(
                                "KJ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppResources.sizes.size012,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: AppResources.sizes.size016,
                            ),
                            Text(
                              "publié le 08/05/2024 à 15:00",
                              style: TextStyle(
                                color: AppResources.colors.darkGrey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Statut :"),
                            SizedBox(
                              width: AppResources.sizes.size016,
                            ),
                            Text(
                              "Annulée",
                              style: TextStyle(
                                color: AppResources.colors.secondary,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: AppResources.sizes.size024),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 16,
                              child: Container(
                                height: AppResources.sizes.size160,
                                decoration: BoxDecoration(
                                  color: AppResources.colors.darkGrey,
                                  borderRadius: AppResources.radius.radius10,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: 16,
                              child: Container(
                                height: AppResources.sizes.size160,
                                decoration: BoxDecoration(
                                  color: AppResources.colors.darkGrey,
                                  borderRadius: AppResources.radius.radius10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppResources.sizes.size016),
                        Row(
                          children: [
                            Expanded(
                              flex: 16,
                              child: Container(
                                height: AppResources.sizes.size160,
                                decoration: BoxDecoration(
                                  color: AppResources.colors.darkGrey,
                                  borderRadius: AppResources.radius.radius10,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: 16,
                              child: Container(
                                height: AppResources.sizes.size160,
                                decoration: BoxDecoration(
                                  color: AppResources.colors.darkGrey,
                                  borderRadius: AppResources.radius.radius10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: AppResources.sizes.size024),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text("Heure d'ouverture :"),
                                SizedBox(
                                  width: AppResources.sizes.size016,
                                ),
                                Text(
                                  "15:00",
                                  style: TextStyle(
                                    color: AppResources.colors.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Date d'ouverture :"),
                                SizedBox(
                                  width: AppResources.sizes.size016,
                                ),
                                Text(
                                  "17/05/2024",
                                  style: TextStyle(
                                    color: AppResources.colors.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        AuctionSubmitBtn(
                          text: "S'inscrire",
                          onPressed: () {},
                          width: AppResources.sizes.size160,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: AppResources.sizes.size024),
                Divider(height: AppResources.sizes.size002),
                SizedBox(height: AppResources.sizes.size024),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              foregroundColor: Colors.white,
                              backgroundColor: AppResources.colors.secondary,
                              radius: AppResources.sizes.size012,
                              child: Text(
                                "KJ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppResources.sizes.size012,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: AppResources.sizes.size016,
                            ),
                            Text(
                              "publié le 08/05/2024 à 15:00",
                              style: TextStyle(
                                color: AppResources.colors.darkGrey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Statut :"),
                            SizedBox(
                              width: AppResources.sizes.size016,
                            ),
                            Text(
                              "Annulée",
                              style: TextStyle(
                                color: AppResources.colors.secondary,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: AppResources.sizes.size024),
                    Row(
                      children: [
                        Expanded(
                          flex: 16,
                          child: Container(
                            height: AppResources.sizes.size340,
                            decoration: BoxDecoration(
                              color: AppResources.colors.darkGrey,
                              borderRadius: AppResources.radius.radius10,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 16,
                          child: Column(
                            children: [
                              Container(
                                height: AppResources.sizes.size160,
                                decoration: BoxDecoration(
                                  color: AppResources.colors.darkGrey,
                                  borderRadius: AppResources.radius.radius10,
                                ),
                              ),
                              SizedBox(height: AppResources.sizes.size016),
                              Container(
                                height: AppResources.sizes.size160,
                                decoration: BoxDecoration(
                                  color: AppResources.colors.darkGrey,
                                  borderRadius: AppResources.radius.radius10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppResources.sizes.size024),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text("Heure d'ouverture :"),
                                SizedBox(
                                  width: AppResources.sizes.size016,
                                ),
                                Text(
                                  "15:00",
                                  style: TextStyle(
                                    color: AppResources.colors.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Date d'ouverture :"),
                                SizedBox(
                                  width: AppResources.sizes.size016,
                                ),
                                Text(
                                  "17/05/2024",
                                  style: TextStyle(
                                    color: AppResources.colors.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        AuctionSubmitBtn(
                          text: "S'inscrire",
                          onPressed: () {},
                          width: AppResources.sizes.size160,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: AppResources.sizes.size024),
                Divider(height: AppResources.sizes.size002),
                SizedBox(height: AppResources.sizes.size024),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              foregroundColor: Colors.white,
                              backgroundColor: AppResources.colors.secondary,
                              radius: AppResources.sizes.size012,
                              child: Text(
                                "KJ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppResources.sizes.size012,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: AppResources.sizes.size016,
                            ),
                            Text(
                              "publié le 08/05/2024 à 15:00",
                              style: TextStyle(
                                color: AppResources.colors.darkGrey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Statut :"),
                            SizedBox(
                              width: AppResources.sizes.size016,
                            ),
                            Text(
                              "Annulée",
                              style: TextStyle(
                                color: AppResources.colors.secondary,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: AppResources.sizes.size024),
                    Row(
                      children: [
                        Expanded(
                          flex: 16,
                          child: Container(
                            height: AppResources.sizes.size340,
                            decoration: BoxDecoration(
                              color: AppResources.colors.darkGrey,
                              borderRadius: AppResources.radius.radius10,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 16,
                          child: Container(
                            height: AppResources.sizes.size340,
                            decoration: BoxDecoration(
                              color: AppResources.colors.darkGrey,
                              borderRadius: AppResources.radius.radius10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppResources.sizes.size024),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text("Heure d'ouverture :"),
                                SizedBox(
                                  width: AppResources.sizes.size016,
                                ),
                                Text(
                                  "15:00",
                                  style: TextStyle(
                                    color: AppResources.colors.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Date d'ouverture :"),
                                SizedBox(
                                  width: AppResources.sizes.size016,
                                ),
                                Text(
                                  "17/05/2024",
                                  style: TextStyle(
                                    color: AppResources.colors.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        AuctionSubmitBtn(
                          text: "S'inscrire",
                          onPressed: () {},
                          width: AppResources.sizes.size160,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: AppResources.sizes.size024),
                Divider(height: AppResources.sizes.size002),
                SizedBox(height: AppResources.sizes.size024),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              foregroundColor: Colors.white,
                              backgroundColor: AppResources.colors.secondary,
                              radius: AppResources.sizes.size012,
                              child: Text(
                                "KJ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppResources.sizes.size012,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: AppResources.sizes.size016,
                            ),
                            Text(
                              "publié le 08/05/2024 à 15:00",
                              style: TextStyle(
                                color: AppResources.colors.darkGrey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Statut :"),
                            SizedBox(
                              width: AppResources.sizes.size016,
                            ),
                            Text(
                              "Annulée",
                              style: TextStyle(
                                color: AppResources.colors.secondary,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: AppResources.sizes.size024),
                    Container(
                      width: double.maxFinite,
                      height: AppResources.sizes.size340,
                      decoration: BoxDecoration(
                        color: AppResources.colors.darkGrey,
                        borderRadius: AppResources.radius.radius10,
                      ),
                    ),
                    SizedBox(height: AppResources.sizes.size024),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text("Heure d'ouverture :"),
                                SizedBox(
                                  width: AppResources.sizes.size016,
                                ),
                                Text(
                                  "15:00",
                                  style: TextStyle(
                                    color: AppResources.colors.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Date d'ouverture :"),
                                SizedBox(
                                  width: AppResources.sizes.size016,
                                ),
                                Text(
                                  "17/05/2024",
                                  style: TextStyle(
                                    color: AppResources.colors.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        AuctionSubmitBtn(
                          text: "S'inscrire",
                          onPressed: () {},
                          width: AppResources.sizes.size160,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: AppResources.sizes.size024),
                Divider(height: AppResources.sizes.size002),
                SizedBox(height: AppResources.sizes.size024),
              ],
            ),
          )*/
          ,
        ),
      ],
    );
  }
}
