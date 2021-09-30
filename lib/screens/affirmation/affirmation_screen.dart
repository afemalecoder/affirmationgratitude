part of affirmation;

class AffirmationScreen extends StatelessWidget {
  const AffirmationScreen({Key? key, this.showBackButton = false})
      : super(key: key);

  final bool showBackButton;

  static const routeName = '/affirmation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AffirmationAppBar(
        label: 'Affirmation',
        tag: 'Affirmation-app-bar',
        showBackButton: showBackButton,
      ),
      body: Consumer<AffirmationNetwork>(
        builder: (context, AffirmationNetwork data, child) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
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
