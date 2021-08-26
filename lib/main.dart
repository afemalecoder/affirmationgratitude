import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:affirmation_gratitude/model/note_operation.dart';
import 'package:affirmation_gratitude/screens/add_notes_screen.dart';
import 'package:affirmation_gratitude/screens/affirmation_screen.dart';
import 'package:affirmation_gratitude/screens/authentication/authentication.dart';
import 'package:affirmation_gratitude/screens/quote_screen.dart';
import 'package:affirmation_gratitude/service/affirmation_auth.dart';

import 'config/style.dart';

Future main() async {
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
        ListenableProvider<NotesOperation>(
          create: (BuildContext context) => NotesOperation(),
        ),
        ListenableProvider<AffirmationAuth>(
          create: (BuildContext context) => AffirmationAuth(),
        )
      ],
      child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Palette.kcToLight,
            textTheme: GoogleFonts.latoTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          initialRoute:
              FirebaseAuth.instance.currentUser == null ? '/auth' : 'home',
          home: const QuoteData(),
          routes: {
            QuoteData.routeName: (context) => const QuoteData(),
            AuthenticationScreen.routeName: (context) =>
                const AuthenticationScreen(),
            AffirmationScreen.routeName: (context) => const AffirmationScreen(),
            AddNoteScreen.routeName: (context) => const AddNoteScreen(),
          }),
    );
  }
}
