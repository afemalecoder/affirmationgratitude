part of home;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: CustomPaint(
            painter: _BackgroundCustomPaint(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const HomeHeader(),
                const Spacer(),
                Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  color: lightThemeData.colorScheme.primaryVariant,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 50),
                    child: Column(
                      children: [
                        HomeCategoryCard(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const AffirmationScreen(
                                  showBackButton: true,
                                ),
                              ),
                            );
                          },
                          title: 'Affirmations',
                          subtitle: 'See all your affirmations',
                        ),
                        HomeCategoryCard(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    const QuoteScreen(showBackButton: true),
                              ),
                            );
                          },
                          title: 'Quotes',
                          subtitle: 'Read from the daily quotes',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
