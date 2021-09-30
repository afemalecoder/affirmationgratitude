class Quote {
  final String quoteText;
  final String quoteDate;
  final String quoteAuthor;
  Quote({
    required this.quoteText,
    required this.quoteDate,
    required this.quoteAuthor,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      quoteText: json['quote']['body'] as String,
      quoteDate: json['qotd_date'] as String,
      quoteAuthor: json['quote']['author'] as String,
    );
  }
}
