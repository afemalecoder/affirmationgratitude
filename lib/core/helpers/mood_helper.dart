import 'package:affirmation_gratitude/model/mood.dart';
import 'package:flutter/material.dart';

class MoodHelper {
  const MoodHelper();

  static const excited = 'Excited';
  static const happy = 'Happy';
  static const neutral = 'Neutral';
  static const sad = 'Sad';

  static List<String> moodTitle = [
    excited,
    happy,
    neutral,
    sad,
  ];
  static List<Mood> moods = [
    Mood(label: excited, icon: Icons.mood),
    Mood(label: happy, icon: Icons.sentiment_satisfied),
    Mood(label: neutral, icon: Icons.sentiment_neutral),
    Mood(label: sad, icon: Icons.mood_bad),
  ];

  IconData getIcon(String label) {
    return moods.firstWhere((Mood mood) {
      return mood.label == label;
    }).icon;
  }

  String getTitle(String title) {
    return moodTitle.firstWhere((String mood) {
      return mood == title;
    }).toString();
  }
}
