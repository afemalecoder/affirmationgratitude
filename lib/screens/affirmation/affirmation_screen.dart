part of affirmation;

class AffirmationScreen extends StatelessWidget {
  const AffirmationScreen({Key? key}) : super(key: key);

  static const routeName = '/affirmation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff464bbd),
      floatingActionButton: const FloatingButton(),
      appBar: const AffirmationAppBar(),
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

class AffirmationAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AffirmationAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(57);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Affirmation'),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            onPressed: () => Navigator.pushNamed(context, QuoteData.routeName),
            icon: const Icon(Icons.home),
          ),
        ),
      ],
    );
  }
}
