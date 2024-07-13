import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuctionSndTextformField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final bool readOnly;
  final int maxLines;

  const AuctionSndTextformField({
    super.key,
    required this.controller,
    required this.title,
    this.keyboardType,
    this.onTap,
    this.validator,
    this.readOnly = false,
    this.maxLines = 1,
  });

  @override
  State<AuctionSndTextformField> createState() =>
      _AuctionSndTextformFieldState();
}

class _AuctionSndTextformFieldState extends State<AuctionSndTextformField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: AppResources.sizes.size016,
          ),
        ),
        SizedBox(height: AppResources.sizes.size008),
        TextFormField(
          maxLines: widget.maxLines,
          cursorColor: AppResources.colors.primary,
          keyboardType: widget.keyboardType,
          readOnly: widget.readOnly,
          controller: widget.controller,
          decoration: InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: AppResources.colors.darkGrey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppResources.colors.secondary,
                width: AppResources.sizes.size002,
              ),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
          ),
          onTap: widget.onTap,
          validator: widget.validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return "Champs obligatoire !";
                }

                if (widget.keyboardType != null &&
                    widget.keyboardType == TextInputType.number &&
                    !value.isNumericOnly) {
                  final numVal = int.tryParse(value);
                  if (numVal == null) {
                    return "Valeur entière !";
                  }

                  return "Champs numerique !";
                }

                return null;
              },
        )
      ],
    );
  }
}
