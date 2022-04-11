part of affirmation;

class AffirmationCard extends StatefulWidget {
  const AffirmationCard(
    this.affirmation, {
    Key? key,
  }) : super(key: key);

  final Affirmation affirmation;

  @override
  State<AffirmationCard> createState() => _AffirmationCardState();
}

class _AffirmationCardState extends State<AffirmationCard> {
  String formattedDate() {
    return DateFormat.yMMMMd().format(
      DateTime.parse(widget.affirmation.date),
    );
  }

  Future<bool> _deleteAffirmation() async {
    bool dismiss = true;
    final network = context.read<AffirmationNetwork>();
    await network
        .deleteAffirmation(
      context,
      widget.affirmation.id!,
    )
        .catchError(
      (_) {
        setState(() {
          dismiss = false;
        });
        showErrorSnackBar(context, 'Error affirmation not deleted');
      },
    );
    if (!mounted) return false;
    if (dismiss) {
      showSnackBar(context, 'Affirmation deleted');
    }
    return dismiss;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (dismiss) async {
        if (dismiss == DismissDirection.endToStart) {
          return _deleteAffirmation();
        }
      },
      direction: DismissDirection.endToStart,
      // resizeDuration: const Duration(milliseconds: 200),
      key: Key('${widget.key}'),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        child: const Icon(
          Icons.delete_forever,
          size: 40,
          color: Colors.white,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        padding: const EdgeInsets.all(15),
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.affirmation.title != null)
                    Flexible(
                      child: Text(
                        widget.affirmation.title!,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  const SizedBox(height: 2),
                  Text(
                    'Date: ${formattedDate()}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Flexible(
                    child: Text(
                      widget.affirmation.content,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AffirmationMood(widget.affirmation.mood),
          ],
        ),
      ),
    );
  }
}

class AffirmationMood extends StatelessWidget {
  const AffirmationMood(
    this.mood, {
    Key? key,
  }) : super(key: key);

  final String mood;

  @override
  Widget build(BuildContext context) {
    return Icon(
      MoodHelper.mood(mood).icon,
      color: Theme.of(context).colorScheme.primaryVariant,
      size: 42,
    );
  }
}
