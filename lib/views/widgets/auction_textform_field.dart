import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class AuctionTextformField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hint;
  final bool obscureText;
  final TextEditingController? sndPwdController;

  const AuctionTextformField({
    super.key,
    this.controller,
    this.keyboardType,
    required this.hint,
    this.obscureText = false,
    this.sndPwdController,
  });

  @override
  State<AuctionTextformField> createState() => _AuctionTextformFieldState();
}

class _AuctionTextformFieldState extends State<AuctionTextformField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: AppResources.colors.primary,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(AppResources.sizes.size008),
        hintText: widget.hint,
        hintStyle: TextStyle(color: AppResources.colors.darkGrey),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppResources.colors.darkGrey,
          ),
          borderRadius: AppResources.radius.radius10,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: AppResources.sizes.size002,
            color: AppResources.colors.secondary,
          ),
          borderRadius: AppResources.radius.radius10,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: AppResources.radius.radius10,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Champ obligatoire !";
        }

        if (widget.keyboardType == TextInputType.emailAddress &&
            !value.isEmail) {
          return "Email invalide !";
        }

        if (widget.keyboardType == TextInputType.visiblePassword &&
            widget.sndPwdController != null) {
          if (value != widget.sndPwdController!.value.text) {
            return "Confirmation de mot de passe invalide !";
          }
        }

        return null;
      },
    );
  }
}
