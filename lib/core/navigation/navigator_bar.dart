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
            onPressed: () => context.read<ThemeProvider>().toggleAppTheme()
            // Navigator.of(context).pushNamed(AddNoteScreen.routeName),

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
