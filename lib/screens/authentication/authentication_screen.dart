part of authentication;

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    deviceSize(context);
    return Scaffold(
      body: Stack(
        children: const <Widget>[
          AuthBackground(),
          AuthFormWrapper(
            children: <Widget>[
              AppLogo(),
              _FormCard(),
              SizedBox(height: 140),
            ],
          ),
        ],
      ),
    );
  }
}
