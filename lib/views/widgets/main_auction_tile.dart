import 'dart:convert';

import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:auctions/controllers/controllers.dart';
import 'package:auctions/models/auction.dart';
import 'package:auctions/models/enums/auction_status.dart';
import 'package:auctions/models/participation.dart';
import 'package:auctions/models/phone.dart';
import 'package:auctions/models/user.dart';
import 'package:auctions/utils/helpers.dart';
import 'package:auctions/views/widgets/auction_submit_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MainAuctionTile extends StatefulWidget {
  final Auction auction;
  final void Function(Auction) onParticipating;
  const MainAuctionTile({
    super.key,
    required this.auction,
    required this.onParticipating,
  });

  @override
  State<MainAuctionTile> createState() => _MainAuctionTileState();
}

class _MainAuctionTileState extends State<MainAuctionTile> {
  User? _loggedUser;

  String _getStatus() {
    switch (widget.auction.status) {
      case AuctionStatus.inProcess:
        return "En cours";
      default:
        return "Nouvelle";
    }
  }

  @override
  void initState() {
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                FutureBuilder(
                  future: userController.getById(widget.auction.admin!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final user = snapshot.data!;
                      final fstChar = user.name![0];
                      final sndChar = user.surname![0];
                      return CircleAvatar(
                        foregroundColor: Colors.white,
                        backgroundColor: AppResources.colors.secondary,
                        radius: AppResources.sizes.size012,
                        child: Text(
                          "$fstChar$sndChar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppResources.sizes.size012,
                          ),
                        ),
                      );
                    }

                    return CircleAvatar(
                      foregroundColor: Colors.white,
                      backgroundColor: AppResources.colors.secondary,
                      radius: AppResources.sizes.size012,
                      child: Text(
                        "I",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppResources.sizes.size012,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: AppResources.sizes.size016,
                ),
                Text(
                  "publié le ${dateFormat.format(widget.auction.createdAt!)} à ${timeFormat.format(widget.auction.createdAt!)}",
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
                  _getStatus(),
                  style: TextStyle(
                    color: AppResources.colors.secondary,
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: AppResources.sizes.size024),
        Text(
          widget.auction.title!,
          style: TextStyle(
            fontSize: AppResources.sizes.size016,
          ),
        ),
        SizedBox(height: AppResources.sizes.size024),
        StreamBuilder(
          stream: phoneController.getAllAsStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final phone = snapshot.data!.firstWhere(
                (phone) => phone.auction == widget.auction.id,
                orElse: () => Phone(),
              );

              return Container(
                width: double.maxFinite,
                height: AppResources.sizes.size340,
                decoration: BoxDecoration(
                  color: AppResources.colors.darkGrey,
                  borderRadius: AppResources.radius.radius10,
                  image: phone.image == null
                      ? null
                      : DecorationImage(
                          image: MemoryImage(
                            base64Decode(phone.image!),
                          ),
                        ),
                ),
              );
            }

            return Container(
              width: double.maxFinite,
              height: AppResources.sizes.size340,
              decoration: BoxDecoration(
                color: AppResources.colors.darkGrey,
                borderRadius: AppResources.radius.radius10,
              ),
            );
          },
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
                      timeFormat.format(widget.auction.startDate!),
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
                      dateFormat.format(widget.auction.startDate!),
                      style: TextStyle(
                        color: AppResources.colors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
            StreamBuilder(
              stream: participationController.getAllAsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final participation = snapshot.data!
                      .where((participation) =>
                          participation.auction == widget.auction.id &&
                          participation.participant == _loggedUser?.id)
                      .firstOrNull;

                  final isNewed = widget.auction.status == AuctionStatus.newed;
                  final inProcess =
                      widget.auction.status == AuctionStatus.inProcess;
                  final userIsParticipant = participation != null;

                  return AuctionSubmitBtn(
                    width: AppResources.sizes.size160,
                    text: userIsParticipant && inProcess
                        ? "Accéder"
                        : userIsParticipant && isNewed
                            ? "Inscrit"
                            : "S'inscrire",
                    onPressed: (!userIsParticipant && inProcess) ||
                            (userIsParticipant && isNewed)
                        ? null
                        : () async {
                            if (!userIsParticipant && isNewed) {
                              EasyLoading.show(status: "Chargement...");
                              final participation =
                                  await participationController.insert(
                                Participation(
                                  participant: _loggedUser?.id,
                                  auction: widget.auction.id,
                                ),
                              );
                              if (participation == null) {
                                EasyLoading.showError(
                                    "Une erreur est survenue !");
                                return;
                              }
                              EasyLoading.showSuccess("Inscription réussie !");
                            }
                            if (userIsParticipant && inProcess) {
                              widget.onParticipating(widget.auction);
                            }
                          },
                  );
                }

                return AuctionSubmitBtn(
                  forLoading: true,
                  onPressed: () {},
                  width: AppResources.sizes.size160,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
