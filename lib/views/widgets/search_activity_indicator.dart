import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:flutter/cupertino.dart';

class SearchActivityIndicator extends StatelessWidget {
  final double? radius;
  final Color? color;
  const SearchActivityIndicator({
    super.key,
    this.radius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        color: color ?? AppResources.colors.primary,
        radius: radius ?? AppResources.sizes.size018,
      ),
    );
  }
}
