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
