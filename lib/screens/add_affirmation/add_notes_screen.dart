part of add_affirmation;

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  static const routeName = '/addNoteScreen';

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  late String title;

  late String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff464bbd),

      /// TODO: use the custom app bar
      appBar: AppBar(
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
              onPressed: () =>
                  Navigator.pushNamed(context, QuoteData.routeName),
              icon: const Icon(Icons.home),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              cursorColor: Colors.white,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xff6b6fca),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Enter Title",
                hintStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              onChanged: (value) {
                title = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: TextField(
                maxLines: 50,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xff6b6fca),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Enter your affirmation here',
                  hintStyle: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
                onChanged: (value) {
                  content = value;
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                final User firebaseUser = FirebaseAuth.instance.currentUser!;
                final notes = FirebaseFirestore.instance;

                await notes
                    .collection('notes/${firebaseUser.uid}/notes')
                    .add({'title': title, 'content': content});

                // final noteCollection = FirebaseFirestore.instance;
                // await noteCollection
                //     .collection('notes/${firebaseUser.uid}/notes')
                //     .add({'title': title, 'content': content});

                Navigator.pop(context);
              },
              child: const Text(
                'ADD',
                style: TextStyle(color: Color(0xff464bbd)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}