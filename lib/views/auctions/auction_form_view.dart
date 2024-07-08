import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:auctions/controllers/controllers.dart';
import 'package:auctions/models/auction.dart';
import 'package:auctions/utils/helpers.dart';
import 'package:auctions/views/widgets/auction_snd_textform_field.dart';
import 'package:auctions/views/widgets/auction_submit_btn.dart';
import 'package:auctions/views/widgets/auction_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AuctionFormView extends StatefulWidget {
  final void Function() onPop;
  const AuctionFormView({super.key, required this.onPop});

  @override
  State<AuctionFormView> createState() => _AuctionFormViewState();
}

class _AuctionFormViewState extends State<AuctionFormView> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final amountController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  void _clearFields() {
    setState(() {
      titleController.text = "";
      startDateController.text = "";
      endDateController.text = "";
      amountController.text = "";
      _startDate = null;
      _endDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            children: [
              BackButton(
                color: AppResources.colors.secondary,
                style: ButtonStyle(
                  iconSize:
                      MaterialStatePropertyAll(AppResources.sizes.size024),
                ),
                onPressed: widget.onPop,
              ),
              Expanded(
                child: Center(
                  child: AuctionTitle(
                    title: "Nouvelle enchère",
                    color: AppResources.colors.secondary,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: AuctionSndTextformField(
                        controller: titleController,
                        title: "Intitule",
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 6,
                      child: AuctionSndTextformField(
                        controller: amountController,
                        title: "Prix minimal (en Yoda)",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: AuctionSndTextformField(
                        readOnly: true,
                        controller: startDateController,
                        title: "Début",
                        keyboardType: TextInputType.datetime,
                        onTap: () async {
                          showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            initialDate:
                                _startDate ?? _endDate ?? DateTime.now(),
                            lastDate: _endDate ?? DateTime(2025),
                          ).then((date) async {
                            if (date != null) {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: _startDate?.toTimeSpan() ??
                                    const TimeOfDay(hour: 0, minute: 0),
                              );
                              if (time != null) {
                                setState(() {
                                  _startDate = date.toSpecificDateTime(time);
                                  startDateController.text =
                                      "${dateFormat.format(_startDate!)} ${timeFormat.format(_startDate!)}";
                                });
                              }
                            }
                          });
                        },
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 6,
                      child: AuctionSndTextformField(
                        readOnly: true,
                        controller: endDateController,
                        title: "Fin",
                        keyboardType: TextInputType.datetime,
                        onTap: () async {
                          showDatePicker(
                            context: context,
                            firstDate: _startDate ?? DateTime.now(),
                            initialDate:
                                _endDate ?? _startDate ?? DateTime.now(),
                            lastDate: DateTime(2025),
                          ).then((date) async {
                            if (date != null) {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: _endDate?.toTimeSpan() ??
                                    const TimeOfDay(hour: 0, minute: 0),
                              );
                              if (time != null) {
                                setState(() {
                                  _endDate = date.toSpecificDateTime(time);
                                  endDateController.text =
                                      "${dateFormat.format(_endDate!)} ${timeFormat.format(_endDate!)}";
                                });
                              }
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AuctionSubmitBtn(
            text: "Soumettre",
            onPressed: () async {
              EasyLoading.show(status: 'Attente...');
              if (formKey.currentState!.validate()) {
                final loggedUser = await userController.getLoggedUser();
                if (loggedUser != null) {
                  final auction = await auctionController.insert(Auction(
                    title: titleController.value.text,
                    startDate: _startDate,
                    endDate: _endDate,
                    admin: loggedUser.id,
                    minPrice: int.parse(amountController.value.text),
                  ));

                  if (auction == null) {
                    EasyLoading.dismiss();
                    EasyLoading.showError('Echec de création');
                    return;
                  }

                  EasyLoading.dismiss();
                  EasyLoading.showSuccess('Enchère enregistrée !');
                  _clearFields();
                  widget.onPop();
                  return;
                }
              }
              EasyLoading.dismiss();
              EasyLoading.showToast("Une erreur s'est produite !");
            },
          ),
          SizedBox(height: AppResources.sizes.size024),
        ],
      ),
    );
  }
}
