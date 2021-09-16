part of home;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AffirmationAppBar(
        elevation: 0,
        showDrawer: true,
        backgroundColor: Colors.transparent,
      ),
      body: CustomPaint(
        painter: _BackgroundCustomPaint(),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: const <Widget>[
              HomeHeader(),
              Spacer(),
              HomeCategoryCard(
                title: 'Affirmations',
                subtitle: 'See all your affirmations',
              ),
              HomeCategoryCard(
                title: 'Quotes',
                subtitle: 'Read from the daily quotes',
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hello Matilda',
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Text(
            'Date 13/09/2021',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10.0),
          Consumer<QuotesNetwork>(
            builder: (builder, QuotesNetwork data, _) {
              if (data.quote == null) {
                return const CircularProgressIndicator();
              } else {
                return AffirmationBody(
                  quote: data.quote!,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
