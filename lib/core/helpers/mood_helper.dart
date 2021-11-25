import 'package:affirmation_gratitude/model/mood.dart';
import 'package:flutter/material.dart';

class MoodHelper {
  const MoodHelper();

  static const excited = 'Excited';
  static const happy = 'Happy';
  static const neutral = 'Neutral';
  static const sad = 'Sad';

  static List<Mood> moods = [
    Mood(label: excited, icon: Icons.mood),
    Mood(label: happy, icon: Icons.sentiment_satisfied),
    Mood(label: neutral, icon: Icons.sentiment_neutral),
    Mood(label: sad, icon: Icons.mood_bad),
  ];

  Mood getMood(String label) {
    return moods.firstWhere((Mood mood) {
      return mood.label == label;
    });
  }
}
