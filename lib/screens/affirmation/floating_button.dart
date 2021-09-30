part of affirmation;

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: lightThemeData.floatingActionButtonTheme.backgroundColor,
      onPressed: () {},
      child: Icon(
        Icons.add,
        size: 30,
        color: lightThemeData.colorScheme.error,
      ),
    );
  }
}
