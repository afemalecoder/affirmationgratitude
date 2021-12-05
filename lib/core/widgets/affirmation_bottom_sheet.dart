import 'package:affirmation_gratitude/core/helpers/mood_helper.dart';
import 'package:affirmation_gratitude/screens/affirmation/affirmation.dart';
import 'package:affirmation_gratitude/services/affirmation_network.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'affirmation_floating_action_button.dart';

class AffirmationBottomSheet extends StatelessWidget {
  const AffirmationBottomSheet({Key? key}) : super(key: key);

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
            return const _AffirmationBottomSheetBody();
          },
        );
      },
      icon: Icons.add,
    );
  }
}

class _AffirmationBottomSheetBody extends StatefulWidget {
  const _AffirmationBottomSheetBody({Key? key}) : super(key: key);

  @override
  _AffirmationBottomSheetBodyState createState() =>
      _AffirmationBottomSheetBodyState();
}

class _AffirmationBottomSheetBodyState
    extends State<_AffirmationBottomSheetBody> {
  String? content;
  int currentIndex = 0;

  void toggleMood(int newIndex) {
    moodsStatus[currentIndex] = false;
    moodsStatus[newIndex] = true;
    setState(() {
      currentIndex = newIndex;
    });
  }

  Future<void> submitData() async {
    await context.read<AffirmationNetwork>().addNewNote(
          date: DateTime.now().toString(),
          title: MoodHelper.moods[currentIndex].label,
          content: content!,
          mood: MoodHelper.moods[currentIndex].label,
        );
    navigateToAffirmationScreen();
  }

  void navigateToAffirmationScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (_) => const AffirmationScreen(
          showBackButton: true,
        ),
      ),
    );
  }

  bool disableButton() {
    return content == null || content!.isEmpty;
  }

  List<bool> moodsStatus = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.80,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              left: 0.0,
              right: 0.0,
              top: -25,
              child: AffirmationFloatingActionButton(
                onPressed: () => Navigator.pop(context),
                icon: Icons.close,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pick a Mood',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <AffirmationMood>[
                          for (int i = 0; i < moodsStatus.length; i++)
                            AffirmationMood(
                              label: MoodHelper.moods[i].label,
                              onTap: () => toggleMood(i),
                              isSelected: moodsStatus[i],
                            ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'Add your affirmation',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          autofocus: true,
                          minLines: 4,
                          maxLines: 12,
                          textInputAction: TextInputAction.newline,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor:
                                Theme.of(context).colorScheme.secondaryVariant,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'Type here...',
                            contentPadding: const EdgeInsets.all(20),
                            hintStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color:
                                  Theme.of(context).colorScheme.primaryVariant,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() => content = value);
                          },
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: disableButton() ? null : submitData,
                          child: const Text('ADD'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AffirmationMood extends StatelessWidget {
  const AffirmationMood({
    Key? key,
    required this.label,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  final String label;
  final void Function() onTap;
  final bool isSelected;

  Duration colorSwitchingDuration() {
    return isSelected
        ? const Duration(milliseconds: 300)
        : const Duration(milliseconds: 500);
  }

  Color? selectionIconColor(BuildContext context) {
    return isSelected
        ? Theme.of(context).colorScheme.surface
        : const Color(0xFFFFFFFF);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: AnimatedContainer(
        height: 70,
        width: 70,
        duration: colorSwitchingDuration(),
        // decoration: ShapeDecoration(
        //   shape: const CircleBorder(),
        //   color: selectionBackground(context),
        // ),
        child: Center(
          child: Column(
            children: [
              Icon(
                MoodHelper.mood(label).icon,
                size: 40,
                color: selectionIconColor(context),
              ),
              Text(
                MoodHelper.mood(label).label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: selectionIconColor(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
