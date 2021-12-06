part of affirmation;

class AffirmationScreen extends StatefulWidget {
  const AffirmationScreen({Key? key, this.showBackButton = false})
      : super(key: key);

  final bool showBackButton;

  static const routeName = '/affirmation';

  @override
  State<AffirmationScreen> createState() => _AffirmationScreenState();
}

class _AffirmationScreenState extends State<AffirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AffirmationAppBar(
        label: 'Affirmation',
        tag: 'Affirmation-app-bar',
        showBackButton: widget.showBackButton,
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
              physics: const BouncingScrollPhysics(),
              itemCount: _docs.length,
              itemBuilder: (context, int i) {
                final QueryDocumentSnapshot<Object?> _doc = _docs[i];
                final Affirmation _affirmation =
                    Affirmation.fromJson(_doc.data()! as Map<String, dynamic>);
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  resizeDuration: const Duration(milliseconds: 200),
                  key: Key(_doc.id),
                  onDismissed: (direction) {
                    setState(() {
                      AffirmationNetwork().deleteAffirmation(_doc.id);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Affirmation was dismissed'),
                      ),
                    );
                  },
                  background: Container(
                    color: Theme.of(context).colorScheme.error,
                    child: const Icon(
                      Icons.delete_forever,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  child: AffirmationCard(
                    _affirmation,
                    key: Key(_doc.id),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
