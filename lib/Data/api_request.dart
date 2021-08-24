import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Quote> fetchQuote() async {
  final response = await http.get(Uri.parse('https://favqs.com/api/qotd'));
  if (response.statusCode == 200) {
    return Quote.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load quote');
  }
}

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
      quoteText: json['quote']['body'].toString(),
      quoteDate: json['qotd_date'].toString(),
      quoteAuthor: json['quote']['author'].toString(),
    );
  }
}
