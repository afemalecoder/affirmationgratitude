part of home;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: CustomPaint(
          painter: _BackgroundCustomPaint(),
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
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
                  color: const Color(0xffC1C8FF),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 50),
                    child: Column(
                      children: [
                        HomeCategoryCard(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(AffirmationScreen.routeName);
                          },
                          title: 'Affirmations',
                          subtitle: 'See all your affirmations',
                        ),
                        HomeCategoryCard(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(QuoteScreen.routeName);
                          },
                          title: 'Quotes',
                          subtitle: 'Read from the daily quotes',
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
