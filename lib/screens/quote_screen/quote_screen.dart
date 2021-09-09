part of quote;

class QuoteData extends StatefulWidget {
  static const routeName = 'quotes';

  const QuoteData({Key? key}) : super(key: key);
  @override
  _QuoteDataState createState() => _QuoteDataState();
}

class _QuoteDataState extends State<QuoteData> {
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
                future: QuotesNetwork().fetchQuote(),
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
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: LimitedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '"${quote.quoteText}"',
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      // color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
