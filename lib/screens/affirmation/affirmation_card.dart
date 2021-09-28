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
        color: const Color(0xFF8A96F6),
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
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                const SizedBox(height: 5),
                Text(
                  'Date: ${DateFormat.yMMMMd().format(
                    DateTime.parse(affirmation.date),
                  )}',
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(height: 5),
                Flexible(
                  child: Text(
                    affirmation.content,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Color(0xFFFFFFFF),
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
      color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
      size: 42,
    );
  }
}
