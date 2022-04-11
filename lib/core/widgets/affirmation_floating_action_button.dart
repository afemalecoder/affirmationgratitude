import 'package:flutter/material.dart';

class AffirmationFloatingActionButton extends StatelessWidget {
  const AffirmationFloatingActionButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor:
          Theme.of(context).floatingActionButtonTheme.backgroundColor,
      onPressed: onPressed,
      child: Icon(
        icon,
        size: 45,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
