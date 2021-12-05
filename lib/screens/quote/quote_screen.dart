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
      appBar: AffirmationAppBar(
        label: 'Quote',
        tag: 'Quote-app-bar',
        showBackButton: widget.showBackButton,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder<Quote>(
            future: futureQuote,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return QuoteBody(
                  quote: snapshot.data!.quoteText,
                  author: snapshot.data!.quoteAuthor,
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class QuoteBody extends StatelessWidget {
  const QuoteBody({
    Key? key,
    required this.quote,
    required this.author,
  }) : super(key: key);

  final String quote;
  final String author;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
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
                  const SizedBox(height: 50),
                  Icon(
                    Icons.format_quote,
                    color: Theme.of(context).colorScheme.primaryVariant,
                    size: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 50,
                      right: 20,
                    ),
                    child: Text(
                      quote,
                      textAlign: TextAlign.start,
                      maxLines: 9,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 30, bottom: 20),
                    child: Text(
                      '- $author',
                      style: TextStyle(

                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primaryVariant,
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
