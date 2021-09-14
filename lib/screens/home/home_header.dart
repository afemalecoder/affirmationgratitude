part of home;

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String username = 'Matilda';
    return Column(
      children: <Widget>[
        const Text(
          'Hello $username',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: Color(0xffC1C8FF),
          ),
        ),
        Text(
          'Date ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
        ),
      ],
    );
  }
}
