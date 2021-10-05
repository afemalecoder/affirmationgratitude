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
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: context.watch<AffirmationNetwork>().watchAffirmations(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('You have no Affirmation 🥲'));
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Oh no! Something went wrong'));
          } else {
            final List<QueryDocumentSnapshot<Object?>> _docs =
                snapshot.data!.docs.reversed.toList();

            return ListView.builder(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemCount: _docs.length,
              itemBuilder: (context, int i) {
                final QueryDocumentSnapshot<Object?> _doc = _docs[i];
                final Affirmation _affirmation =
                    Affirmation.fromJson(_doc.data()! as Map<String, dynamic>);
                return AffirmationCard(
                  _affirmation,
                  key: Key(_doc.id),
                );
              },
            );
          }
        },
      ),
    );
  }
}
