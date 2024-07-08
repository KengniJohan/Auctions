import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:auctions/controllers/controllers.dart';
import 'package:auctions/views/widgets/auction_search_bar.dart';
import 'package:auctions/views/widgets/auction_submit_btn.dart';
import 'package:flutter/material.dart';

class MainAuctionListView extends StatefulWidget {
  const MainAuctionListView({super.key});

  @override
  State<MainAuctionListView> createState() => _MainAuctionListViewState();
}

class _MainAuctionListViewState extends State<MainAuctionListView> {
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
                  onChanged: (value) {},
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
          child: SingleChildScrollView(
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
          ),
        ),
      ],
    );
  }
}
