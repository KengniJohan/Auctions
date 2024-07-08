import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:auctions/utils/helpers.dart';
import 'package:flutter/material.dart';

class UserAuctionTile extends StatelessWidget {
  final String title;
  final DateTime dateTime;
  final int phones;
  const UserAuctionTile({
    super.key,
    required this.title,
    required this.dateTime,
    this.phones = 0,
  });

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
                Container(
                  width: AppResources.sizes.size048,
                  height: AppResources.sizes.size048,
                  decoration: BoxDecoration(
                    color: AppResources.colors.darkGrey,
                    borderRadius: AppResources.radius.radius24,
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 8,
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
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
                  timeFormat.format(dateTime),
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
                  dateFormat.format(dateTime),
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
                Text(
                  phones.toString(),
                  style: TextStyle(
                    color: AppResources.colors.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: AppResources.sizes.size012,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
