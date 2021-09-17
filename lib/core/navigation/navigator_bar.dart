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
    return Scaffold(
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
        backgroundColor: const Color(0xff8793FA),
        child: const Icon(
          Icons.add,
          size: 45,
          color: Color(0xffffffff),
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AffirNavigationBar(
        currentIndex: currentIndex,
        onTap: (int screenIndex) {
          if (screenIndex == 2) return;
          setState(() => currentIndex = screenIndex);
        },
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
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Affirmation'),
        BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.format_quote), label: 'Quote'),
        BottomNavigationBarItem(icon: Icon(Icons.person_pin), label: 'Profile'),
      ],
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        color: Theme.of(context).colorScheme.secondaryVariant,
      ),
      type: BottomNavigationBarType.fixed,
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        color: Theme.of(context).colorScheme.secondaryVariant,
      ),
      unselectedItemColor: const Color(0xffC1C8FF),
      selectedItemColor: const Color(0xff8793FA),
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
