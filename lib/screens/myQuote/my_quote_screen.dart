import 'package:affirmation_gratitude/core/widgets/affirmation_app_bar.dart';
import 'package:flutter/material.dart';

class MyQuoteScreen extends StatelessWidget {
  const MyQuoteScreen({Key? key}) : super(key: key);

  static const routeName = '/myQuote';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AffirmationAppBar(
        label: 'My Quote',
        tag: 'MyQuote-app-bar',
        showBackButton: true,
      ),
      body: ListView(

      ),
    );
  }
}
