part of quote;

class QuoteScreen extends StatelessWidget {
  static const routeName = '/quotes';

  const QuoteScreen({Key? key, this.showBackButton = false}) : super(key: key);

  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AffirmationAppBar(
        label: 'Quote',
        tag: 'Quote-app-bar',
        showBackButton: showBackButton,
      ),
      backgroundColor: const Color(0xff464bbd),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<QuotesNetwork>(
                builder: (builder, QuotesNetwork network, _) {
                  if (network.quote == null) {
                    print('no data!');
                    return const CircularProgressIndicator();
                  } else {
                    return AffirmationBody(
                      quote: network.quote!,
                    );
                  }
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
