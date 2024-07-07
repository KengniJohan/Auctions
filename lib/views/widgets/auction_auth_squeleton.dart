import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:flutter/material.dart';

class AuctionAuthSqueleton extends StatefulWidget {
  final Widget form;
  const AuctionAuthSqueleton({super.key, required this.form});

  @override
  State<AuctionAuthSqueleton> createState() => _AuctionAuthSqueletonState();
}

class _AuctionAuthSqueletonState extends State<AuctionAuthSqueleton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(AppResources.sizes.size016),
              color: AppResources.colors.primary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Auctions",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppResources.sizes.size064,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    "La plateforme des bonnes affaires en matière de téléphones",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppResources.sizes.size018,
                      decoration: TextDecoration.none,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(AppResources.sizes.size032),
              child: widget.form,
            ),
          ),
        ],
      ),
    );
  }
}
