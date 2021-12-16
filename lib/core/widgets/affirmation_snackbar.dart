import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String label) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(label),
      backgroundColor: Theme.of(context).colorScheme.surface,
    ),
  );
}

void showErrorSnackBar(BuildContext context, String label) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(label, style: const TextStyle(fontSize: 15),),
      backgroundColor: Theme.of(context).colorScheme.error,
    ),
  );
}