part of profile;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _firebaseUser = FirebaseAuth.instance.currentUser!;
  final _db = FirebaseFirestore.instance;
  int affirmationCount = 0;

  Future<void> getAffirmationsCount() async {
    final String userAffirmationsPath =
        'affirmations/${_firebaseUser.uid}/affirmations';
    final int length = await _db
        .collection(userAffirmationsPath)
        .get()
        .then((value) => value.docs.length);
    setState(() {
      affirmationCount = length;
    });
  }

  @override
  void initState() {
    getAffirmationsCount();
    super.initState();
  }

  final List<String> settingTitles = [
    'My Quotes',
    'Dark mode',
    'Edit Login details',
    'Log Out',
  ];

  Future<void> logOut() async {
    await context.read<AffirmationAuth>().logOut(context);
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(AuthenticationScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final String username = _firebaseUser.displayName!;
    return Scaffold(
      appBar: const AffirmationAppBar(
        label: 'My Account',
        tag: 'profile-app-bar',
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            username,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'You have written $affirmationCount affirmations.\nKeep it up!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Card(
              color: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SettingOption(
                    title: settingTitles[0],
                    onPressed: () {},
                  ),
                  Consumer<ThemeProvider>(
                    builder: (context, ThemeProvider theme, _) {
                      return SettingOption(
                        title: settingTitles[1],
                        themeSwitch: ThemeSwitch(
                          value: theme.darkTheme,
                          onChanged: (bool value) {
                            theme.toggleAppTheme();
                          },
                        ),
                      );
                    },
                  ),
                  SettingOption(
                    title: settingTitles[2],
                    onPressed: () {},
                  ),
                  SettingOption(
                    title: settingTitles[3],
                    onPressed: () {
                      showCupertinoDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: const Text('Log out'),
                            actions: [
                              TextButton(
                                onPressed: logOut,
                                child: const Text('YES'),
                              ),
                              TextButton(
                                child: const Text('NO'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingOption extends StatelessWidget {
  const SettingOption({
    Key? key,
    required this.title,
    this.onPressed,
    this.themeSwitch,
  }) : super(key: key);

  final String title;
  final ThemeSwitch? themeSwitch;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          if (themeSwitch != null)
            themeSwitch!
          else
            IconButton(
              icon: Icon(
                Icons.navigate_next,
                size: 40,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: onPressed,
            ),
        ],
      ),
    );
  }
}

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({
    Key? key,
    this.value,
    required this.onChanged,
  }) : super(key: key);

  final bool? value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value ?? false,
      onChanged: onChanged,
    );
  }
}
