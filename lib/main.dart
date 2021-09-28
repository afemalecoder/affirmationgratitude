import 'package:affirmation_gratitude/core/affirmation_operation.dart';
import 'package:affirmation_gratitude/core/navigation/navigation.dart';
import 'package:affirmation_gratitude/screens/add_affirmation/add_affirmation.dart';
import 'package:affirmation_gratitude/screens/affirmation/affirmation.dart';
import 'package:affirmation_gratitude/screens/authentication/authentication.dart';
import 'package:affirmation_gratitude/screens/home/home.dart';
import 'package:affirmation_gratitude/screens/quote/quote.dart';
import 'package:affirmation_gratitude/services/affirmation_auth.dart';
import 'package:affirmation_gratitude/services/quotes_network.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'config/style.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<AffirmationOperation>(
          create: (BuildContext context) => AffirmationOperation(),
        ),
        ListenableProvider<AffirmationAuth>(
          create: (BuildContext context) => AffirmationAuth(),
        ),
        ListenableProvider<QuotesNetwork>(
          create: (BuildContext context) => QuotesNetwork(),
        ),
      ],
      child: const _APP(),
    );
  }
}

class _APP extends StatelessWidget {
  const _APP({Key? key}) : super(key: key);

  Future<void> getQuotes(BuildContext context) async {
    final QuotesNetwork network = context.read<QuotesNetwork>();
    if (network.quote == null) await network.getQuote();
  }

  @override
  Widget build(BuildContext context) {
    getQuotes(context);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Palette.kcToLight,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: StreamBuilder<User?>(
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          return FirebaseAuth.instance.currentUser == null
              ? const AuthenticationScreen()
              : const AffirmationNavigation();
        },
      ),
      routes: {
        AffirmationNavigation.routeName: (context) =>
            const AffirmationNavigation(),
        QuoteScreen.routeName: (context) => const QuoteScreen(),
        AuthenticationScreen.routeName: (context) =>
            const AuthenticationScreen(),
        AffirmationScreen.routeName: (context) => const AffirmationScreen(),
        AddNoteScreen.routeName: (context) => const AddNoteScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
