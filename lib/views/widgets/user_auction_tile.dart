import 'dart:convert';

import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:auctions/controllers/controllers.dart';
import 'package:auctions/models/auction.dart';
import 'package:auctions/models/enums/auction_status.dart';
import 'package:auctions/models/phone.dart';
import 'package:auctions/utils/helpers.dart';
import 'package:auctions/views/widgets/auction_submit_btn.dart';
import 'package:auctions/views/widgets/auction_title.dart';
import 'package:auctions/views/widgets/search_activity_indicator.dart';
import 'package:auctions/views/widgets/warning_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UserAuctionTile extends StatefulWidget {
  final Auction auction;
  const UserAuctionTile({
    super.key,
    required this.auction,
  });

  @override
  State<UserAuctionTile> createState() => _UserAuctionTileState();
}

class _UserAuctionTileState extends State<UserAuctionTile> {
  String _selectedPhoneId = "";

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppResources.sizes.size002,
      surfaceTintColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Container(
        padding: EdgeInsets.all(AppResources.sizes.size008),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppResources.colors.darkGrey,
            width: 0.1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                StreamBuilder(
                  stream: phoneController.getAllAsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final phone = snapshot.data!.firstWhere(
                          (phone) => phone.auction == widget.auction.id,
                          orElse: () => Phone());
                      return Container(
                        width: AppResources.sizes.size048,
                        height: AppResources.sizes.size048,
                        decoration: BoxDecoration(
                            color: AppResources.colors.darkGrey,
                            borderRadius: AppResources.radius.radius24,
                            image: phone.image == null
                                ? null
                                : DecorationImage(
                                    image: MemoryImage(
                                        base64Decode(phone.image!)))),
                      );
                    }
                    return Container(
                      width: AppResources.sizes.size048,
                      height: AppResources.sizes.size048,
                      decoration: BoxDecoration(
                        color: AppResources.colors.darkGrey,
                        borderRadius: AppResources.radius.radius24,
                      ),
                    );
                  },
                ),
                const Spacer(),
                Flexible(
                  flex: 8,
                  child: Text(
                    widget.auction.title ?? "...",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                PopupMenuButton(
                  onSelected: (value) async {
                    if (value == Icons.block) {
                      EasyLoading.show(status: "Chargement...");
                      final auction = widget.auction;
                      auction.status = AuctionStatus.canceled;
                      await auctionController.updateAuction(
                          auction.id!, auction);
                      EasyLoading.showSuccess("Statut modifiée !");
                    } else if (value == Icons.timer) {
                      EasyLoading.show(status: "Chargement...");
                      final auction = widget.auction;
                      final relatedPhones = (await phoneController.getAll())
                          .where((phone) => phone.auction == auction.id);
                      if (relatedPhones.isEmpty) {
                        EasyLoading.showError("Opération impossible !");
                        return;
                      }
                      auction.status = AuctionStatus.inProcess;
                      await auctionController.updateAuction(
                          auction.id!, auction);
                      EasyLoading.showSuccess("Statut modifiée !");
                    } else if (value == Icons.add_call) {
                      showBottomSheet(
                        context: context,
                        elevation: AppResources.sizes.size008,
                        enableDrag: true,
                        builder: (context) => StatefulBuilder(
                          builder: (context, setState) => SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: AppResources.sizes.size024,
                                top: AppResources.sizes.size024,
                                right: AppResources.sizes.size024,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AuctionTitle(
                                    title: "Choisir un téléphone à ajouter",
                                    color: AppResources.colors.secondary,
                                    fontSize: AppResources.sizes.size018,
                                  ),
                                  SizedBox(height: AppResources.sizes.size024),
                                  StreamBuilder(
                                    stream: phoneController.getAllAsStream(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return const WarningMessage(
                                          message: "Une erreur est survenue !",
                                        );
                                      }

                                      if (snapshot.hasData) {
                                        final phones = snapshot.data!
                                            .where((phone) =>
                                                phone.auction == null)
                                            .toList();

                                        return phones.isEmpty
                                            ? const WarningMessage(
                                                message:
                                                    "Aucun téléphone trouvée !",
                                              )
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: phones.length,
                                                itemBuilder: (context, index) {
                                                  final phone = phones[index];
                                                  return ListTile(
                                                    leading: phone.image == null
                                                        ? Container(
                                                            width: AppResources
                                                                .sizes.size016,
                                                            height: AppResources
                                                                .sizes.size016,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  AppResources
                                                                      .colors
                                                                      .grey,
                                                            ),
                                                          )
                                                        : Image.memory(
                                                            base64Decode(
                                                              phone.image!,
                                                            ),
                                                          ),
                                                    title: Text(
                                                      "${phone.brand} ${phone.model}",
                                                    ),
                                                    trailing: Radio(
                                                      value: phone.id,
                                                      groupValue:
                                                          _selectedPhoneId
                                                                  .isEmpty
                                                              ? null
                                                              : _selectedPhoneId,
                                                      activeColor: AppResources
                                                          .colors.secondary,
                                                      onChanged: (value) {
                                                        this.setState(() {
                                                          setState(() {
                                                            _selectedPhoneId =
                                                                phone.id!;
                                                          });
                                                        });
                                                      },
                                                    ),
                                                  );
                                                },
                                              );
                                      }

                                      return SearchActivityIndicator(
                                        radius: AppResources.sizes.size012,
                                      );
                                    },
                                  ),
                                  SizedBox(height: AppResources.sizes.size024),
                                  AuctionSubmitBtn(
                                    text: "Valider",
                                    onPressed: _selectedPhoneId.isEmpty
                                        ? null
                                        : () async {
                                            EasyLoading.show(
                                                status: "Chargement...");
                                            final phone = await phoneController
                                                .getById(_selectedPhoneId);
                                            if (phone != null) {
                                              phone.auction = widget.auction.id;
                                              await phoneController.updatePhone(
                                                  phone.id!, phone);
                                              this.setState(() {
                                                setState(() {
                                                  _selectedPhoneId = "";
                                                });
                                              });
                                              EasyLoading.showSuccess(
                                                  "Téléphone ajoutée !");
                                              return;
                                            }
                                            EasyLoading.dismiss();
                                            EasyLoading.showError(
                                                "Une erreur s'est produite !");
                                          },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    if (widget.auction.status == AuctionStatus.newed)
                      PopupMenuItem(
                        value: Icons.add_call,
                        child: Icon(
                          Icons.add_call,
                          color: AppResources.colors.secondary,
                        ),
                      ),
                    if (widget.auction.status == AuctionStatus.newed)
                      const PopupMenuItem(
                        value: Icons.timer,
                        child: Icon(
                          Icons.timer,
                          color: Colors.amber,
                        ),
                      ),
                    if (widget.auction.status == AuctionStatus.inProcess)
                      PopupMenuItem(
                        value: Icons.check,
                        child: Icon(
                          Icons.check,
                          color: Colors.greenAccent.shade700,
                        ),
                      ),
                    if (widget.auction.status == AuctionStatus.newed ||
                        widget.auction.status == AuctionStatus.rescheduled)
                      PopupMenuItem(
                        value: Icons.change_circle,
                        child: Icon(
                          Icons.change_circle,
                          color: AppResources.colors.secondary,
                        ),
                      ),
                    if (widget.auction.status == AuctionStatus.newed)
                      const PopupMenuItem(
                        value: Icons.block,
                        child: Icon(
                          Icons.block,
                          color: Colors.redAccent,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Heure d'ouverture :",
                  style: TextStyle(
                    color: AppResources.colors.darkGrey,
                    fontSize: AppResources.sizes.size012,
                  ),
                ),
                SizedBox(
                  width: AppResources.sizes.size016,
                ),
                Text(
                  widget.auction.startDate == null
                      ? "..."
                      : timeFormat.format(widget.auction.startDate!),
                  style: TextStyle(
                    color: AppResources.colors.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: AppResources.sizes.size012,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Date d'ouverture :",
                  style: TextStyle(
                    color: AppResources.colors.darkGrey,
                    fontSize: AppResources.sizes.size012,
                  ),
                ),
                SizedBox(
                  width: AppResources.sizes.size016,
                ),
                Text(
                  widget.auction.startDate == null
                      ? "..."
                      : dateFormat.format(widget.auction.startDate!),
                  style: TextStyle(
                    color: AppResources.colors.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: AppResources.sizes.size012,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Nombre de téléphones :",
                  style: TextStyle(
                    color: AppResources.colors.darkGrey,
                    fontSize: AppResources.sizes.size012,
                  ),
                ),
                SizedBox(
                  width: AppResources.sizes.size016,
                ),
                StreamBuilder(
                  stream: phoneController.getAllAsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final phones = snapshot.data!
                          .where((phone) => phone.auction == widget.auction.id)
                          .length;
                      return Text(
                        phones.toString(),
                        style: TextStyle(
                          color: AppResources.colors.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: AppResources.sizes.size012,
                        ),
                      );
                    }

                    return Text(
                      "0",
                      style: TextStyle(
                        color: AppResources.colors.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: AppResources.sizes.size012,
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
