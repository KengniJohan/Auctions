import 'dart:convert';

import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:auctions/controllers/controllers.dart';
import 'package:auctions/models/phone.dart';
import 'package:auctions/models/user.dart';
import 'package:auctions/views/widgets/auction_search_bar.dart';
import 'package:auctions/views/widgets/auction_submit_btn.dart';
import 'package:auctions/views/widgets/phone_list_tile.dart';
import 'package:auctions/views/widgets/search_activity_indicator.dart';
import 'package:auctions/views/widgets/warning_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PhoneListView extends StatefulWidget {
  final void Function() onCreatingNewPhone;
  const PhoneListView({super.key, required this.onCreatingNewPhone});

  @override
  State<PhoneListView> createState() => _PhoneListViewState();
}

class _PhoneListViewState extends State<PhoneListView>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  String _searchKey = "";
  User? _loggedUser;

  List<Phone> _filteredList(List<Phone> data) => data.where((phone) {
        final filterByBrand =
            phone.brand?.toLowerCase().contains(_searchKey.toLowerCase()) ??
                false;
        final filterByModel =
            phone.model?.toLowerCase().contains(_searchKey.toLowerCase()) ??
                false;
        final filterByOs =
            phone.os?.toLowerCase().contains(_searchKey.toLowerCase()) ?? false;
        final filterByDescription = phone.description
                ?.toLowerCase()
                .contains(_searchKey.toLowerCase()) ??
            false;

        return filterByBrand ||
            filterByModel ||
            filterByOs ||
            filterByDescription;
      }).toList();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final user = await userController.getLoggedUser();
      setState(() {
        _loggedUser = user;
      });
    });
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
          text: "Nouveau Télephone",
          onPressed: widget.onCreatingNewPhone,
          width: AppResources.sizes.size200,
        ),
        SizedBox(height: AppResources.sizes.size024),
        TabBar(
          controller: _tabController,
          indicatorColor: AppResources.colors.secondary,
          tabs: const [
            Tab(
              text: "Enregistré soi-même",
            ),
            Tab(
              text: "Acquis aux enchères",
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(AppResources.sizes.size016),
          color: AppResources.colors.grey,
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "Image",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppResources.colors.secondary,
                      fontSize: AppResources.sizes.size016,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Marque",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppResources.colors.secondary,
                      fontSize: AppResources.sizes.size016,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Modèle",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppResources.colors.secondary,
                      fontSize: AppResources.sizes.size016,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Système d’exploitation",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppResources.colors.secondary,
                      fontSize: AppResources.sizes.size016,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Prix (en Yoda)",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppResources.colors.secondary,
                      fontSize: AppResources.sizes.size016,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Batterie (en %)",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppResources.colors.secondary,
                      fontSize: AppResources.sizes.size016,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              StreamBuilder(
                stream: phoneController.getAllAsStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const WarningMessage(
                      message: "Une erreur est survenue !",
                    );
                  }

                  if (snapshot.hasData) {
                    final phones = _filteredList(snapshot.data!
                        .where((phone) => phone.owner == _loggedUser?.id)
                        .toList());

                    return phones.isEmpty
                        ? const WarningMessage(
                            message: "Aucun téléphone trouvé !",
                          )
                        : ListView.builder(
                            itemCount: phones.length,
                            itemBuilder: (context, index) {
                              final phone = phones[index];
                              return PhoneListTile(
                                imageData: phone.image == null
                                    ? null
                                    : base64Decode(phone.image!),
                                brand: phone.brand!,
                                model: phone.model!,
                                os: phone.os,
                                minPrice: phone.price,
                                batterie: phone.autonomie,
                              );
                            },
                          );
                  }
                  return const SearchActivityIndicator();
                },
              ),
              Container()
            ],
          ),
        )
      ],
    );
  }
}
