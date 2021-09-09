import 'package:affirmation_gratitude/screens/quote_screen/quote.dart';
import 'package:flutter/material.dart';

class AffirmationAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AffirmationAppBar({
    Key? key,
    this.showDrawer = false,
    this.elevation = 4,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(57);

  final bool showDrawer;
  final double elevation;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: showDrawer ? SizedBox.shrink() : const Text('Affirmation'),
      elevation: elevation,
      centerTitle: true,
      leading: showDrawer
          ? null
          : Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: showDrawer
              ? SizedBox.shrink()
              : IconButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    QuoteData.routeName,
                  ),
                  icon: const Icon(Icons.home),
                ),
        ),
      ],
    );
  }
}
