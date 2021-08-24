import 'dart:async';

import 'package:affirmation_gratitude/screens/authentication_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:affirmation_gratitude/Data/api_request.dart';

class QuoteData extends StatefulWidget {
  static const routeName = 'home';

  const QuoteData({Key? key}) : super(key: key);
  @override
  _QuoteDataState createState() => _QuoteDataState();
}

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class _QuoteDataState extends State<QuoteData> {
  Future<void> _signOut() async {
    await _firebaseAuth.signOut().then(
          (value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const AuthenticationScreen(),
            ),
            ModalRoute.withName('/auth'),
          ),
        );
  }

  late Future<Quote> futureQuote;
  @override
  void initState() {
    super.initState();
    futureQuote = fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff464bbd),
                image: DecorationImage(
                  image: AssetImage('assets/images/logoPen.png'),
                ),
              ),
              child: Text(''),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('My Affirmation'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => Navigator.pushNamed(context, '/affirmation'),
            ),
            ListTile(
              leading: const Icon(Icons.add_circle),
              title: const Text('Add Affirmation'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => Navigator.pushNamed(context, '/addNoteScreen'),
            ),
            ListTile(
              leading: const Icon(Icons.save),
              title: const Text('My Quotes'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {},
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
              onTap: () {
                _signOut();
              },
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xff464bbd),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<Quote>(
                future: futureQuote,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 50, left: 10, right: 10),
                          child: Text(
                            '"${snapshot.data!.quoteText}"',
                            style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 50.0),
                          child: Text(
                            snapshot.data!.quoteAuthor,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Text('error');
                  }
                  return const CircularProgressIndicator();
                }),
            Container(
              padding: const EdgeInsets.only(top: 100, bottom: 20),
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)))),
                onPressed: () {
                  Navigator.pushNamed(context, '/affirmation');
                },
                child: const Text(
                  'Add todays affirmation',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
