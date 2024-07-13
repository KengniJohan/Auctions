import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:auctions/controllers/controllers.dart';
import 'package:auctions/models/auction.dart';
import 'package:auctions/models/participation.dart';
import 'package:auctions/models/proposition.dart';
import 'package:auctions/models/user.dart';
import 'package:auctions/utils/helpers.dart';
import 'package:auctions/views/widgets/auction_submit_btn.dart';
import 'package:auctions/views/widgets/auction_textform_field.dart';
import 'package:auctions/views/widgets/auction_title.dart';
import 'package:auctions/views/widgets/search_activity_indicator.dart';
import 'package:auctions/views/widgets/warning_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AuctionPriceProposalView extends StatefulWidget {
  final Auction auction;
  final void Function() onPop;
  const AuctionPriceProposalView({
    super.key,
    required this.auction,
    required this.onPop,
  });

  @override
  State<AuctionPriceProposalView> createState() =>
      _AuctionPriceProposalViewState();
}

class _AuctionPriceProposalViewState extends State<AuctionPriceProposalView> {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final List<Participation> _auctionParticipations = List.empty(growable: true);

  User? _loggedUser;
  Participation? _participation;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final user = await userController.getLoggedUser();
      final participations = await participationController.getAll();
      setState(() {
        _loggedUser = user;
        _participation = participations
            .where((participation) =>
                participation.participant == user?.id &&
                participation.auction == widget.auction.id)
            .firstOrNull;
        _auctionParticipations.addAll(participations.where(
            (participation) => participation.auction == widget.auction.id));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            BackButton(
              color: AppResources.colors.secondary,
              style: ButtonStyle(
                iconSize: MaterialStatePropertyAll(AppResources.sizes.size024),
              ),
              onPressed: widget.onPop,
            ),
            Expanded(
              child: Center(
                child: AuctionTitle(
                  title: widget.auction.title!,
                  color: AppResources.colors.secondary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppResources.sizes.size036),
        Expanded(
          child: StreamBuilder(
            stream: propositionController.getAllAsStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const WarningMessage(
                    message: "Une erreur s'est produite !");
              }

              if (snapshot.hasData) {
                final propositions = snapshot.data!
                    .where((proposition) => _auctionParticipations.any(
                        (participation) =>
                            proposition.participation == participation.id))
                    .toList();

                return propositions.isEmpty
                    ? const WarningMessage(
                        message: "Aucune proposition trouvée !")
                    : ListView.builder(
                        reverse: true,
                        itemCount: propositions.length,
                        itemBuilder: (context, index) {
                          final proposition = propositions[index];
                          return Container(
                            width: AppResources.sizes.size120,
                            alignment:
                                proposition.participation == _participation?.id
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            margin: EdgeInsets.symmetric(
                              vertical: AppResources.sizes.size012,
                            ),
                            padding: EdgeInsets.all(AppResources.sizes.size008),
                            decoration: BoxDecoration(
                              color: proposition.isLast
                                  ? AppResources.colors.secondary
                                  : proposition.participation ==
                                          _participation?.id
                                      ? AppResources.colors.primary
                                      : AppResources.colors.darkGrey,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${proposition.amount} Yoda",
                                  style: TextStyle(
                                    color: proposition.participation !=
                                            _participation?.id
                                        ? null
                                        : Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (proposition.createdAt != null)
                                  Text(
                                    "${dateFormat.format(proposition.createdAt!)} ${timeFormat.format(proposition.createdAt!)}",
                                    style: TextStyle(
                                      color: proposition.participation !=
                                              _participation?.id
                                          ? null
                                          : Colors.white,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      );
              }

              return const SearchActivityIndicator();
            },
          ),
        ),
        SizedBox(height: AppResources.sizes.size024),
        Padding(
          padding: EdgeInsets.only(
            bottom: AppResources.sizes.size024,
          ),
          child: Form(
            key: formKey,
            child: Row(
              children: [
                Flexible(
                  flex: 14,
                  child: AuctionTextformField(
                    controller: amountController,
                    hint: "Entrer votre proposition",
                    keyboardType: TextInputType.number,
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 4,
                  child: AuctionSubmitBtn(
                    onPressed: () async {
                      EasyLoading.show(status: "Chargement...");
                      if (formKey.currentState!.validate()) {
                        final amount = int.parse(amountController.value.text);
                        final account = await accountController
                            .getByOwner(_loggedUser?.id ?? '');
                        if (account?.amount != null &&
                            account!.amount! < amount) {
                          EasyLoading.showError("Solde insuffisant !");
                          return;
                        }
                        final proposition =
                            await propositionController.insert(Proposition(
                          participation: _participation?.id,
                          amount: amount,
                        ));
                        if (proposition == null) {
                          EasyLoading.showError("Une erreur s'est produite !");
                          return;
                        }
                        setState(() {
                          amountController.text = "";
                        });
                      }
                      EasyLoading.dismiss();
                    },
                    child: const Icon(Icons.send),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
