part of affirmation;

class AffirmationCard extends StatelessWidget {
  const AffirmationCard(
    this.affirmation, {
    Key? key,
  }) : super(key: key);

  final Affirmation affirmation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
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
                if (affirmation.title != null)
                  Flexible(
                    child: Text(
                      affirmation.title!,
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
                const SizedBox(height: 5),
                Text(
                  'Date: ${DateFormat.yMMMMd().format(
                    DateTime.parse(affirmation.date),
                  )}',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
                const SizedBox(height: 5),
                Flexible(
                  child: Text(
                    affirmation.content,
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
          const AffirmationMood(MoodHelper.sad),
        ],
      ),
    );
  }
}

class AffirmationMood extends StatelessWidget {
  const AffirmationMood(
    this.label, {
    Key? key,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Icon(
      const MoodHelper().getIcon(label),
      color: Theme.of(context).colorScheme.primaryVariant,
      size: 42,
    );
  }
}
