part of affirmation;

class AffirmationScreen extends StatelessWidget {
  const AffirmationScreen({Key? key, this.showBackButton = false})
      : super(key: key);

  final bool showBackButton;

  static const routeName = '/affirmation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AffirmationAppBar(
            showBackButton: showBackButton,
          ),
          Consumer<AffirmationOperation>(
            builder: (context, AffirmationOperation data, child) {
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemCount: data.notes.length,
                  itemBuilder: (context, index) {
                    return AffirmationCard(
                      data.notes[index],
                      key: Key('$index'),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
// from => home
// inter => passing by
// to => arrive to the app bar

class AffirmationAppBar extends StatelessWidget {
  const AffirmationAppBar({Key? key, this.showBackButton = false})
      : super(key: key);
  final bool showBackButton;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      width: double.infinity,
      child: Card(
        color: const Color(0xff8A96F6),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                if (showBackButton)
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                const Text(
                  'Affirmation',
                  style: TextStyle(
                    fontSize: 28,
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
