part of quote;

class QuoteScreen extends StatefulWidget {
  static const routeName = '/quotes';

  const QuoteScreen({Key? key, this.showBackButton = false}) : super(key: key);

  final bool showBackButton;

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  Future<void> _getQuote() async {
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
                  //isSelected: network.isSelected!,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class QuoteBody extends StatefulWidget {
  const QuoteBody({
    Key? key,
    required this.quote,
    //required this.isSelected,
  }) : super(key: key);

  final Quote quote;
  //final bool isSelected;

  @override
  State<QuoteBody> createState() => _QuoteBodyState();
}

class _QuoteBodyState extends State<QuoteBody> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final String _quoteBody = widget.quote.quote['body'] as String;
    final String _author = widget.quote.quote['author'] as String;

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
                child: IconButton(
                  color: Colors.white,
                  icon: Icon(isSelected ? Icons.star : Icons.star_outline),
                  onPressed: () async {
                    // await context.read<AffirmationNetwork>().addQuote(
                    //       date: DateTime.now().toString(),
                    //       author: _author,
                    //       quote: _quoteBody,
                    //     );
                    setState(() {
                      isSelected = true;
                      //if _shouldUpdateQuote is true
                    });
                  },
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
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, top: 30, bottom: 20),
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
