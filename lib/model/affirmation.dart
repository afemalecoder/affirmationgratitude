class Affirmation {
  final String? id;
  final String date;
  final String? title;
  final String content;
  final String mood;

  Affirmation({
    this.id,
    required this.date,
    required this.title,
    required this.content,
    required this.mood,
  });
  factory Affirmation.fromJson(Map<String, dynamic> json) {
    return Affirmation(
      // id: json['id'] as String,
      content: json['content'] as String,
      date: json['date'] as String,
      mood: json['mood'] as String,
      title: json['title'] as String,
    );
  }
}
