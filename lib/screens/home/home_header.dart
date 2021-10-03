part of home;

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String username = FirebaseAuth.instance.currentUser!.displayName!;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hello \n$username',
              maxLines: 2,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            Text(
              'Date ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
