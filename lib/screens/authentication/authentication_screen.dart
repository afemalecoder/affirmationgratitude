part of authentication;

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    deviceSize(context);
    return Scaffold(
      appBar: const AppBarCard(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: const <Widget>[
          AuthFormWrapper(
            children: <Widget>[
              _FormCard(),
              SizedBox(height: 140),
            ],
          ),
        ],
      ),
    );
  }
}
