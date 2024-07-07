import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:auctions/configs/routes/app_routes.dart';
import 'package:auctions/controllers/controllers.dart';
import 'package:auctions/utils/helpers';
import 'package:auctions/views/widgets/auction_nav_chip.dart';
import 'package:auctions/views/widgets/auction_search_bar.dart';
import 'package:auctions/views/widgets/auction_submit_btn.dart';
import 'package:auctions/views/widgets/auction_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final onglets = [
    "Accueil",
    "A propos",
    "Tableau de bord",
    "Mes enchères",
    "Mes téléphones",
    "Mon compte"
  ];

  final RxInt selectedIndex = RxInt(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: AppResources.colors.primary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: AppResources.sizes.size024,
                        ),
                        child: AuctionTitle(
                          title: "Auctions",
                          color: Colors.white,
                          fontSize: AppResources.sizes.size032,
                        ),
                      ),
                      SizedBox(height: AppResources.sizes.size032),
                      Obx(() => Column(
                            children: onglets
                                .mapIndexed((onglet, index) => AuctionNavChip(
                                      title: onglet,
                                      selected: selectedIndex.value == index,
                                      onSelected: (selected) {
                                        if (selected) {
                                          selectedIndex(index);
                                        }
                                      },
                                    ))
                                .toList(),
                          ))
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: AppResources.sizes.size016),
                    child: AuctionNavChip(
                      title: "Déconnexion",
                      selected: false,
                      onSelected: (value) async {
                        await userController.logout();
                        Get.offAllNamed(AppRoutes.signIn);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.only(
                left: AppResources.sizes.size024,
                top: AppResources.sizes.size024,
                right: AppResources.sizes.size024,
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: AppResources.sizes.size032),
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
                                    backgroundColor:
                                        AppResources.colors.secondary,
                                    child: Text(
                                      "${data.name![0]}${data.surname![0]}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
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
                        children: [],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

/*Container(
                            child: Column(
                              children: [
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            foregroundColor: Colors.white,
                                            backgroundColor:
                                                AppResources.colors.secondary,
                                            radius: AppResources.sizes.size012,
                                            child: Text(
                                              "KJ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    AppResources.sizes.size012,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: AppResources.sizes.size016,
                                          ),
                                          Text(
                                            "publié le 08/05/2024 à 15:00",
                                            style: TextStyle(
                                              color:
                                                  AppResources.colors.darkGrey,
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
                                              color:
                                                  AppResources.colors.secondary,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )*/
