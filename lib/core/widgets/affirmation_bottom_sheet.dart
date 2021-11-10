import 'package:affirmation_gratitude/core/helpers/mood_helper.dart';
import 'package:affirmation_gratitude/screens/affirmation/affirmation.dart';
import 'package:flutter/material.dart';

import 'affirmation_floating_action_button.dart';

class AffirmationBottomSheet extends StatefulWidget {
  const AffirmationBottomSheet({Key? key}) : super(key: key);

  @override
  _AffirmationBottomSheetState createState() => _AffirmationBottomSheetState();
}

class _AffirmationBottomSheetState extends State<AffirmationBottomSheet> {
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
                    child: AffirmationFloatingActionButton(onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => const AffirmationScreen(
                            showBackButton: true,
                          ),
                        ),
                      );
                    }),
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
                          children: const [
                            AffirmationMood(MoodHelper.excited),
                            AffirmationMood(MoodHelper.happy),
                            AffirmationMood(MoodHelper.neutral),
                            AffirmationMood(MoodHelper.sad),
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
                          child: TextField(
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
                              // setState(() => content = value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
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
    return Column(
      children: [
        Icon(
          const MoodHelper().getIcon(label),
          color: Theme.of(context).colorScheme.secondary,
          size: 42,
        ),
        Text(
          const MoodHelper().getTitle(label),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
