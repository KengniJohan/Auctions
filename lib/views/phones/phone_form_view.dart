import 'dart:convert';
import 'dart:typed_data';

import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:auctions/controllers/controllers.dart';
import 'package:auctions/models/phone.dart';
import 'package:auctions/models/user.dart';
import 'package:auctions/views/widgets/auction_snd_textform_field.dart';
import 'package:auctions/views/widgets/auction_submit_btn.dart';
import 'package:auctions/views/widgets/auction_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

class PhoneFormView extends StatefulWidget {
  final void Function() onPop;
  const PhoneFormView({super.key, required this.onPop});

  @override
  State<PhoneFormView> createState() => _PhoneFormViewState();
}

class _PhoneFormViewState extends State<PhoneFormView> {
  final formKey = GlobalKey<FormState>();
  final brandController = TextEditingController();
  final modelController = TextEditingController();
  final osController = TextEditingController();
  final screenController = TextEditingController();
  final autonomieController = TextEditingController();
  final ramController = TextEditingController();
  final romController = TextEditingController();
  final frontalCameraController = TextEditingController();
  final backCameraController = TextEditingController();
  final priceController = TextEditingController();
  final decriptionController = TextEditingController();

  Uint8List _imageData = Uint8List.fromList(List.empty());
  bool _showErrorMessage = false;
  User? _loggedUser;

  void _clearFields() {
    setState(() {
      brandController.text = "";
      modelController.text = "";
      osController.text = "";
      screenController.text = "";
      autonomieController.text = "";
      ramController.text = "";
      romController.text = "";
      frontalCameraController.text = "";
      backCameraController.text = "";
      priceController.text = "";
      decriptionController.text = "";
      _imageData = Uint8List.fromList(List.empty());
    });
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
                    title: "Nouveau téléphone",
                    color: AppResources.colors.secondary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppResources.sizes.size036),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: AppResources.sizes.size024,
                    ),
                    child: ListView(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: AuctionSndTextformField(
                                controller: brandController,
                                title: "Marque",
                                keyboardType: TextInputType.name,
                              ),
                            ),
                            const Spacer(flex: 2),
                            Expanded(
                              flex: 6,
                              child: AuctionSndTextformField(
                                controller: modelController,
                                title: "Modèle",
                                keyboardType: TextInputType.name,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppResources.sizes.size016),
                        Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: AuctionSndTextformField(
                                controller: osController,
                                title: "Système d'exploitation",
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  return null;
                                },
                              ),
                            ),
                            const Spacer(flex: 2),
                            Expanded(
                              flex: 6,
                              child: AuctionSndTextformField(
                                controller: screenController,
                                title: "Taille de l'écran",
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    final doubleVal = double.tryParse(value);
                                    final intVal = int.tryParse(value);
                                    if (doubleVal == null && intVal == null) {
                                      return "Champ numérique !";
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppResources.sizes.size016),
                        Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: AuctionSndTextformField(
                                controller: autonomieController,
                                title: "Autonomie de la batterie",
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    final intVal = int.tryParse(value);
                                    if (intVal == null) {
                                      return "Champ numérique !";
                                    }
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const Spacer(flex: 2),
                            Expanded(
                              flex: 6,
                              child: AuctionSndTextformField(
                                controller: ramController,
                                title: "Mémoire vive (en Go)",
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    final intVal = int.tryParse(value);
                                    if (intVal == null) {
                                      return "Champ numérique !";
                                    }
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppResources.sizes.size016),
                        Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: AuctionSndTextformField(
                                controller: romController,
                                title: "Mémoire morte (en Go)",
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    final intVal = int.tryParse(value);
                                    if (intVal == null) {
                                      return "Champ numérique !";
                                    }
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const Spacer(flex: 2),
                            Expanded(
                              flex: 6,
                              child: AuctionSndTextformField(
                                controller: frontalCameraController,
                                title: "Caméra frontal",
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    final intVal = int.tryParse(value);
                                    if (intVal == null) {
                                      return "Champ numérique !";
                                    }
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppResources.sizes.size016),
                        Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: AuctionSndTextformField(
                                controller: backCameraController,
                                title: "Caméra arrière",
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    final intVal = int.tryParse(value);
                                    if (intVal == null) {
                                      return "Champ numérique !";
                                    }
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const Spacer(flex: 2),
                            Expanded(
                              flex: 6,
                              child: AuctionSndTextformField(
                                controller: priceController,
                                title: "Prix (en Yoda)",
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    final intVal = int.tryParse(value);
                                    if (intVal == null) {
                                      return "Champ numérique !";
                                    }
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppResources.sizes.size016),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 6,
                              child: AuctionSndTextformField(
                                maxLines: 5,
                                controller: decriptionController,
                                title: "Description",
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  return null;
                                },
                              ),
                            ),
                            const Spacer(flex: 2),
                            Expanded(
                              flex: 6,
                              child: AuctionSubmitBtn(
                                text: "Enregistrer",
                                onPressed: () async {
                                  EasyLoading.show(status: "Enregistrement...");
                                  if (formKey.currentState!.validate() &&
                                      _imageData.isNotEmpty) {
                                    final phone =
                                        await phoneController.insert(Phone(
                                      brand: brandController.value.text,
                                      model: modelController.value.text,
                                      os: osController.value.text.isEmpty
                                          ? null
                                          : osController.value.text,
                                      screen:
                                          screenController.value.text.isEmpty
                                              ? null
                                              : double.parse(
                                                  screenController.value.text),
                                      autonomie: autonomieController
                                              .value.text.isEmpty
                                          ? null
                                          : int.parse(
                                              autonomieController.value.text),
                                      ram: ramController.value.text.isEmpty
                                          ? null
                                          : int.parse(ramController.value.text),
                                      rom: romController.value.text.isEmpty
                                          ? null
                                          : int.parse(romController.value.text),
                                      frontalCamera: frontalCameraController
                                              .value.text.isEmpty
                                          ? null
                                          : int.parse(frontalCameraController
                                              .value.text),
                                      backCamera: backCameraController
                                              .value.text.isEmpty
                                          ? null
                                          : int.parse(
                                              backCameraController.value.text),
                                      description: decriptionController
                                              .value.text.isEmpty
                                          ? null
                                          : decriptionController.value.text,
                                      image: base64Encode(_imageData),
                                      owner: _loggedUser?.id,
                                    ));
                                    setState(() {
                                      _showErrorMessage = false;
                                    });
                                    if (phone != null) {
                                      EasyLoading.dismiss();
                                      EasyLoading.showSuccess(
                                          "Téléphone enregistrée avec succès !");
                                      _clearFields();
                                    }
                                    EasyLoading.dismiss();
                                    return;
                                  }
                                  if (_imageData.isEmpty) {
                                    setState(() {
                                      _showErrorMessage = true;
                                    });
                                  }
                                  EasyLoading.dismiss();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        Container(
                          height: AppResources.sizes.size200,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _showErrorMessage
                                  ? Colors.red
                                  : AppResources.colors.darkGrey,
                            ),
                          ),
                          child: _imageData.isEmpty
                              ? null
                              : Image.memory(_imageData),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: _imageData.isNotEmpty
                                ? null
                                : () async {
                                    final picker = ImagePicker();
                                    final pickedImage = await picker.pickImage(
                                      source: ImageSource.gallery,
                                    );
                                    if (pickedImage != null) {
                                      final data =
                                          await pickedImage.readAsBytes();
                                      setState(() {
                                        _imageData = data;
                                      });
                                    }
                                  },
                            style: ButtonStyle(
                              foregroundColor: const MaterialStatePropertyAll(
                                Colors.white,
                              ),
                              backgroundColor: MaterialStatePropertyAll(
                                _imageData.isNotEmpty
                                    ? AppResources.colors.darkGrey
                                    : AppResources.colors.secondary,
                              ),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: AppResources.radius.radius10),
                              ),
                            ),
                            icon: const Icon(Icons.camera_alt),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
