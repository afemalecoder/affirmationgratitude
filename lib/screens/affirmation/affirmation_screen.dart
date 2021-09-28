part of affirmation;

class AffirmationScreen extends StatelessWidget {
  const AffirmationScreen({Key? key, this.showBackButton = false})
      : super(key: key);

  final bool showBackButton;

  static const routeName = '/affirmation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'Affirmation',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ),
        leading: showBackButton
            ? Padding(
                padding: const EdgeInsets.only(left: 20),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 25,
                  ),
                ),
              )
            : null,
        backgroundColor: const Color(0xff8A96F6),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))),
      ),
      body: Consumer<AffirmationOperation>(
        builder: (context, AffirmationOperation data, child) {
          return ListView.builder(
            itemCount: data.notes.length,
            itemBuilder: (context, index) {
              return AffirmationCard(
                data.notes[index],
                key: Key('$index'),
              );
            },
          );
        },
      ),
    );
  }
}
