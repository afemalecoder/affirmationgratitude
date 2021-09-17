part of profile;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () async {
          await AffirmationAuth().logOut(context);
          Navigator.pushReplacementNamed(
              context, AuthenticationScreen.routeName);
        },
        child: const Text('Signout'),
      ),
    );
  }
}
