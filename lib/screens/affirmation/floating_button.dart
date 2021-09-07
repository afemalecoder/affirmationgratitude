part of affirmation;

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: () => Navigator.pushNamed(
        context,
        AddNoteScreen.routeName,
      ),
      child: const Icon(
        Icons.add,
        size: 30,
        color: Color(0xff464bbd),
      ),
    );
  }
}
