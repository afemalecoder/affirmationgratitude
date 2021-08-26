part of authentication;

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      key: Key('$key'),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 94.0,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(logo),
          ),
        ),
      ),
    );
  }
}
