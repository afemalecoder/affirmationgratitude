part of quote;

class QuoteScreen extends StatefulWidget {
  static const routeName = '/quotes';

  const QuoteScreen({Key? key, this.showBackButton = false}) : super(key: key);

  final bool showBackButton;

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  late Future<Quote> futureQuote;

  @override
  void initState() {
    super.initState();
    futureQuote = QuotesNetwork().getQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AffirmationAppBar(
        label: 'Quote',
        tag: 'Quote-app-bar',
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Quote>(
                future: futureQuote,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return AffirmationBody(
                      quote: snapshot.data!.quoteText,
                      author: snapshot.data!.quoteAuthor,
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),
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
    required this.author,
  }) : super(key: key);

  final String quote;
  final String author;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 400,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Stack(
            children: [
              Positioned(
                right: 20,
                top: 16,
                child: Icon(
                  Icons.star_outline,
                  color: Theme.of(context).colorScheme.primaryVariant,
                  size: 50,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.format_quote,
                    color: Theme.of(context).colorScheme.primaryVariant,
                    size: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 20),
                    child: Text(
                      quote,
                      textAlign: TextAlign.start,
                      maxLines: 9,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 30),
                    child: Text(
                      author,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
