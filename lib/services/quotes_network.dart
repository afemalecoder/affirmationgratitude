import 'dart:convert';
import 'package:affirmation_gratitude/model/quotes.dart';
import 'package:http/http.dart' as http;

class QuotesNetwork {
  Future<Quote> fetchQuote() async {
    final response = await http.get(
      Uri.parse('https://favqs.com/api/qotd'),
    );
    if (response.statusCode == 200) {
      return Quote.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load quote');
    }
  }
}
