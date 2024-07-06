import 'package:auctions/configs/ressources/app_ressources.dart';
import 'package:flutter/material.dart';

class AuctionSubmitBtn extends StatefulWidget {
  final String text;
  final void Function() onPressed;
  const AuctionSubmitBtn(
      {super.key, required this.text, required this.onPressed});

  @override
  State<AuctionSubmitBtn> createState() => _AuctionSubmitBtnState();
}

class _AuctionSubmitBtnState extends State<AuctionSubmitBtn> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll(AppResources.colors.secondary),
        foregroundColor: const MaterialStatePropertyAll(Colors.white),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: AppResources.radius.radius10),
        ),
        textStyle: MaterialStatePropertyAll(
          TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppResources.sizes.size018,
          ),
        ),
        padding: MaterialStatePropertyAll(
          EdgeInsets.all(AppResources.sizes.size016),
        ),
        overlayColor: MaterialStatePropertyAll(
          AppResources.colors.primary.withOpacity(0.5),
        ),
        fixedSize:
            const MaterialStatePropertyAll(Size.fromWidth(double.maxFinite)),
      ),
      child: Text(widget.text),
    );
  }
}
