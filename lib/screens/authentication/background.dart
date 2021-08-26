part of authentication;

class AuthBackground extends StatelessWidget {
  const AuthBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(loginBackground),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
