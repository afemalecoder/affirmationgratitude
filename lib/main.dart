import 'package:affirmation_gratitude/core/navigation/navigation.dart';
import 'package:affirmation_gratitude/core/theme/theme.dart';

import 'package:affirmation_gratitude/screens/affirmation/affirmation.dart';
import 'package:affirmation_gratitude/screens/authentication/authentication.dart';
import 'package:affirmation_gratitude/screens/home/home.dart';
import 'package:affirmation_gratitude/screens/myQuote/my_quote_screen.dart';
import 'package:affirmation_gratitude/screens/quote/quote.dart';
import 'package:affirmation_gratitude/services/affirmation_auth.dart';
import 'package:affirmation_gratitude/services/affirmation_network.dart';
import 'package:affirmation_gratitude/services/quotes_network.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        ListenableProvider<ThemeProvider>(
          create: (BuildContext context) => ThemeProvider(),
        ),
        ListenableProvider<AffirmationNetwork>(
          create: (BuildContext context) => AffirmationNetwork(),
        ),
        ListenableProvider<AffirmationAuth>(
          create: (BuildContext context) => AffirmationAuth(),
        ),
        ListenableProvider<QuotesNetwork>(
          create: (BuildContext context) => QuotesNetwork(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (_, ThemeProvider theme, __) {
          return MaterialApp(
            theme: theme.affirmationTheme,
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
              AffirmationScreen.routeName: (context) =>
                  const AffirmationScreen(),
              HomeScreen.routeName: (context) => const HomeScreen(),
              MyQuoteScreen.routeName: (context) => const MyQuoteScreen(),
            },
          );
        },
      ),
    );
  }
}
