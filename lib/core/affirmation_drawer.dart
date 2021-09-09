import 'package:affirmation_gratitude/screens/add_Affirmation/add_affirmation.dart';
import 'package:affirmation_gratitude/screens/affirmation/affirmation.dart';
import 'package:affirmation_gratitude/screens/authentication/authentication.dart';
import 'package:affirmation_gratitude/screens/home/home.dart';
import 'package:affirmation_gratitude/screens/quote_screen/quote.dart';
import 'package:affirmation_gratitude/services/affirmation_auth.dart';
import 'package:affirmation_gratitude/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AffirmationDrawer extends StatefulWidget {
  const AffirmationDrawer({Key? key}) : super(key: key);

  @override
  _AffirmationDrawerState createState() => _AffirmationDrawerState();
}

class _AffirmationDrawerState extends State<AffirmationDrawer> {
  Future<void> _signOut() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final AffirmationAuth affirmationAuth = context.read<AffirmationAuth>();

    await affirmationAuth.logOut(context);

    if (_firebaseAuth.currentUser == null) {
      Navigator.of(context).pushReplacementNamed(
        AuthenticationScreen.routeName,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff464bbd),
              image: DecorationImage(
                image: AssetImage(logoPen),
              ),
            ),
            child: SizedBox.shrink(),
          ),
          ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => Navigator.pushNamed(
                    context,
                    HomeScreen.routeName,
                  )),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('My Affirmation'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () =>
                Navigator.pushNamed(context, AffirmationScreen.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.add_circle),
            title: const Text('Add Affirmation'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => Navigator.pushNamed(context, AddNoteScreen.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.save),
            title: const Text('My Quotes'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => Navigator.pushNamed(context, QuoteData.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () => _signOut(),
          ),
        ],
      ),
    );
  }
}
