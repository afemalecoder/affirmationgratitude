part of home;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: AffirmationDrawer(),
      appBar: AffirmationAppBar(
        elevation: 0,
        showDrawer: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: const Color(0xff464bbd),
      body: Center(
        child: WelcomeText(),
      ),
    );
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'WELCOME',
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Text(
            'afemalecoder',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10.0),
          Consumer<QuotesNetwork>(
            builder: (builder, QuotesNetwork network, _) {
              if (network.quote == null) {
                return const CircularProgressIndicator();
              } else {
                return AffirmationBody(
                  quote: network.quote!,
                );
              }
            },
          ),
          // FutureBuilder<Quote>(
          //   future: QuotesNetwork().fetchQuote(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const CircularProgressIndicator();
          //     } else if (snapshot.hasError) {
          //       return const Text('error');
          //     } else if (snapshot.data == null) {
          //       return const Text('There are no qoutes');
          //     } else {
          //       return AffirmationBody(
          //         quote: snapshot.data!,
          //       );
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
