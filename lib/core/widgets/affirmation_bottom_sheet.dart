import 'package:affirmation_gratitude/core/helpers/mood_helper.dart';
import 'package:affirmation_gratitude/model/mood.dart';
import 'package:affirmation_gratitude/screens/affirmation/affirmation.dart';
import 'package:affirmation_gratitude/services/affirmation_network.dart';

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'affirmation_floating_action_button.dart';

class AffirmationBottomSheet extends StatefulWidget {
  const AffirmationBottomSheet({Key? key}) : super(key: key);

  @override
  _AffirmationBottomSheetState createState() => _AffirmationBottomSheetState();
}

class _AffirmationBottomSheetState extends State<AffirmationBottomSheet> {
  late String content;
  int currentIndex = 0;

  void toggleMood(int newIndex){
    moodsStatus[currentIndex] = false;
    moodsStatus[newIndex] = true;
    setState(() {
      currentIndex = newIndex;
    });
  }
  List<bool> moodsStatus = [ true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return AffirmationFloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Theme.of(context).colorScheme.primaryVariant,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
            ),
          ),
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.80,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: AffirmationFloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icons.close,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 60,
                      left: 40,
                      right: 40,
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pick a Mood',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <AffirmationMood>[
                        for (int i = 0; i < moodsStatus.length; i++)
                          AffirmationMood(MoodHelper.moods[i].label, () => toggleMood(i), isSelected: moodsStatus[i] ,),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Add your \naffirmation',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.80,
                          //TODO: TextField above keyboard or autofocus on text that's being typed.
                          child: TextFormField(
                            autofocus: true,
                            maxLines: 50,
                            textInputAction: TextInputAction.newline,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .secondaryVariant,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: 'Type here...',
                              contentPadding: const EdgeInsets.all(20),
                              hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() => content = value);
                            },
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              context.read<AffirmationNetwork>().addNewNote(
                                  date: DateTime.now().toString(),
                                  title: 'Mood',
                                  content: content,
                                  mood: 'Happy');
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (_) => const AffirmationScreen(
                                    showBackButton: true,
                                  ),
                                ),
                              );
                            },
                            child: const Text('add')),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      icon: Icons.add,
    );
  }
}

class AffirmationMood extends StatefulWidget {
  const AffirmationMood(
    this.label, this.onTap, {
    Key? key, required this.isSelected,
  }) : super(key: key);

  final String label;
  final void Function() onTap;
final bool isSelected;

  @override
  State<AffirmationMood> createState() => _AffirmationMoodState();
}

class _AffirmationMoodState extends State<AffirmationMood> {


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 70,
        width: 60,
        decoration: ShapeDecoration(
          shape: const CircleBorder(),
          color: !widget.isSelected ? Colors.transparent : Colors.red,
        ),
         child: Column(
            children: [
              Icon(
                const MoodHelper().getMood(widget.label).icon,
                size: 40,
              ),
         Text(
          const MoodHelper().getMood(widget.label).label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        ],
          ),
      ),
    );
  }
}
