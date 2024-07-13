import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:auctions/configs/routes/app_routes.dart';
import 'package:auctions/controllers/controllers.dart';
import 'package:auctions/models/auction.dart';
import 'package:auctions/utils/helpers.dart';
import 'package:auctions/views/about_view.dart';
import 'package:auctions/views/auctions/auction_form_view.dart';
import 'package:auctions/views/auctions/auction_price_proposal_view.dart';
import 'package:auctions/views/auctions/main_auction_list_view.dart';
import 'package:auctions/views/auctions/user_auction_list_view.dart';
import 'package:auctions/views/phones/phone_form_view.dart';
import 'package:auctions/views/phones/phone_list_view.dart';
import 'package:auctions/views/widgets/auction_nav_chip.dart';
import 'package:auctions/views/widgets/auction_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _onglets = [
    "Accueil",
    "A propos",
    "Tableau de bord",
    "Mes enchères",
    "Mes téléphones",
    "Mon compte"
  ];

  final RxInt _selectedIndex = RxInt(0);
  bool _forAuctionForm = false;
  bool _forPhoneForm = false;
  Auction _participatingValue = Auction();

  @override
  Widget build(BuildContext context) {
    final views = [
      _participatingValue.id == null
          ? MainAuctionListView(
              onParticipating: (value) {
                setState(() {
                  _participatingValue = value;
                });
              },
            )
          : AuctionPriceProposalView(
              auction: _participatingValue,
              onPop: () {
                setState(() {
                  _participatingValue = Auction();
                });
              }),
      const AboutView(),
      Container(),
      _forAuctionForm
          ? AuctionFormView(onPop: () {
              setState(() {
                _forAuctionForm = false;
              });
            })
          : UserAuctionListView(
              onCreatingNewAuction: () {
                setState(() {
                  _forAuctionForm = true;
                });
              },
            ),
      _forPhoneForm
          ? PhoneFormView(onPop: () {
              setState(() {
                _forPhoneForm = false;
              });
            })
          : PhoneListView(onCreatingNewPhone: () {
              setState(() {
                _forPhoneForm = true;
              });
            }),
      Container(),
    ];

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
                            children: _onglets
                                .mapIndexed((onglet, index) => AuctionNavChip(
                                      title: onglet,
                                      selected: _selectedIndex.value == index,
                                      onSelected: (selected) {
                                        if (selected) {
                                          _selectedIndex(index);
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
            child: Obx(() => Padding(
                  padding: EdgeInsets.only(
                    left: AppResources.sizes.size024,
                    top: AppResources.sizes.size024,
                    right: AppResources.sizes.size024,
                  ),
                  child: views[_selectedIndex.value],
                )),
          )
        ],
      ),
    );
  }
}
