part of affirmation;

class AffirmationScreen extends StatelessWidget {
  const AffirmationScreen({Key? key}) : super(key: key);

  static const routeName = '/affirmation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AffirmationAppBar(),
      floatingActionButton: const FloatingButton(),
      backgroundColor: const Color(0xff464bbd),
      body: Consumer<NotesOperation>(
        builder: (context, NotesOperation data, child) {
          return ListView.builder(
            itemCount: data.getNotes.length,
            itemBuilder: (context, index) {
              return NotesCard(
                data.getNotes[index],
                key: Key('$index'),
              );
            },
          );
        },
      ),
    );
  }
}
