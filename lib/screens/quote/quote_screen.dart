part of quote;

class QuoteScreen extends StatefulWidget {
  static const routeName = '/quotes';

  const QuoteScreen({Key? key, this.showBackButton = false}) : super(key: key);

  final bool showBackButton;

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {

Future<void> _getQuote() async{
 await context.read<QuotesNetwork>().getQuote();
}


  @override
  void initState() {
   _getQuote();
    super.initState();
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
          child: Consumer<QuotesNetwork>(
            builder: (builder, QuotesNetwork network, _) {
              if (network.quote == null) {
                return const CircularProgressIndicator();
              } else {
                return QuoteBody(
                  quote: network.quote!,
                );
              }
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
  }) : super(key: key);

  final Quote quote;


  @override
  Widget build(BuildContext context) {
    final String _quoteBody =  quote.quote['body'] as String;
    final String _author =  quote.quote['author'] as String;
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
                      _quoteBody,
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
                      '- $_author',
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
