part of quote;

class QuoteData extends StatefulWidget {
  static const routeName = 'home';

  const QuoteData({Key? key}) : super(key: key);
  @override
  _QuoteDataState createState() => _QuoteDataState();
}

class _QuoteDataState extends State<QuoteData> {
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
      drawer: const AffirmationDrawer(),
      backgroundColor: const Color(0xff464bbd),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Quote>(
                future: futureQuote,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('error');
                  } else if (snapshot.data == null) {
                    return const Text('There are no qoutes');
                  } else {
                    return AffirmationBody(
                      quote: snapshot.data!,
                    );
                  }
                },
              ),
              const AddButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class AffirmationBody extends StatelessWidget {
  const AffirmationBody({
    Key? key,
    required this.quote,
  }) : super(key: key);

  final Quote quote;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Text(
            '"${quote.quoteText}"',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 50.0),
          child: Text(
            quote.quoteAuthor,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 100, bottom: 20),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
        onPressed: () => Navigator.pushNamed(context, AddNoteScreen.routeName),
        child: const Text(
          'New affirmation',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
