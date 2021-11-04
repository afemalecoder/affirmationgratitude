part of navigation;

class AffirmationNavigation extends StatefulWidget {
  const AffirmationNavigation({Key? key}) : super(key: key);

  static const String routeName = '/navigation';

  @override
  _AffirmationNavigationState createState() => _AffirmationNavigationState();
}

class _AffirmationNavigationState extends State<AffirmationNavigation> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    const List<Widget> screens = [
      HomeScreen(),
      AffirmationScreen(),
      AffirmationScreen(),
      QuoteScreen(),
      ProfileScreen(),
    ];
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (
            Widget child,
            Animation<double> primary,
            Animation<double> secondary,
          ) {
            return SharedAxisTransition(
              animation: primary,
              secondaryAnimation: secondary,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
          child: screens[currentIndex],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor:
              Theme.of(context).floatingActionButtonTheme.backgroundColor,
          child: Icon(
            Icons.add,
            size: 45,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () {
            showModalBottomSheet(
                backgroundColor: Theme.of(context).colorScheme.surface,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                ),
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 40, left: 40, right: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pick a Mood',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [],
                            ),
                          ),
                          Text(
                            'Add your \naffirmation',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              maxLines: 50,
                              textInputAction: TextInputAction.newline,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    Theme.of(context).colorScheme.primary,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: 'Type here...',
                                hintStyle: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                              onChanged: (value) {
                                // setState(() => content = value);
                              },
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary:
                                  Theme.of(context).colorScheme.primaryVariant,
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () async {},
                            child: const Text(
                              'ADD',
                              style: TextStyle(color: Color(0xff464bbd)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AffirNavigationBar(
          currentIndex: currentIndex,
          onTap: (int screenIndex) {
            if (screenIndex == 2) return;
            setState(() => currentIndex = screenIndex);
          },
        ),
      ),
    );
  }
}

class MoodPicker extends StatelessWidget {
  const MoodPicker({
    Key? key,
    required this.mood,
    required this.onTap,
    required this.iconMood,
  }) : super(key: key);

  final String mood;
  final void Function()? onTap;
  final IconData iconMood;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: const [
          Icon(Icons.sentiment_very_satisfied),
          Text('mood'),
        ],
      ),
    );
  }
}

class AffirNavigationBar extends StatelessWidget {
  const AffirNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  final int currentIndex;
  final void Function(int) onTap;

  @override
  BottomNavigationBar build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.library_books), label: 'Affirmation'),
        BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.format_quote), label: 'Quote'),
        BottomNavigationBarItem(icon: Icon(Icons.person_pin), label: 'Profile'),
      ],
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        color: Theme.of(context).colorScheme.primary,
      ),
      type: BottomNavigationBarType.fixed,
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        color: Theme.of(context).colorScheme.primaryVariant,
      ),
      unselectedItemColor: Theme.of(context).colorScheme.primaryVariant,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
