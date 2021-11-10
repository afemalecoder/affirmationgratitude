import 'package:flutter/material.dart';

class AffirmationFloatingActionButton extends StatelessWidget {
  const AffirmationFloatingActionButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor:
          Theme.of(context).floatingActionButtonTheme.backgroundColor,
      onPressed: onPressed,
      child: Icon(
        Icons.add,
        size: 45,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
