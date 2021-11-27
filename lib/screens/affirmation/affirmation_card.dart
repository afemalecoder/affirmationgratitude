part of affirmation;

class AffirmationCard extends StatelessWidget {
  const AffirmationCard(
    this.affirmation, {
    Key? key,
  }) : super(key: key);

  final Affirmation affirmation;

  String formattedDate() {
    return DateFormat.yMMMMd().format(
      DateTime.parse(affirmation.date),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          AffirmationMood(affirmation.mood),
        ],
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
