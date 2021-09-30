import 'dart:convert';

import 'package:affirmation_gratitude/core/utilities/prefs_string.dart';
import 'package:affirmation_gratitude/model/quotes.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuotesNetwork with ChangeNotifier {
  QuotesNetwork();

  Quote? quote;

  final String _baseUrlAPI = 'https://favqs.com/api';

  Future<void> cacheQuote(Quote quote) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(PrefsString.quoteAuthor, quote.quoteAuthor);

    await prefs.setString(PrefsString.quoteText, quote.quoteText);

    await prefs.setString(PrefsString.quoteDate, quote.quoteDate);
  }

  Future<Response> _getQuote() async {
    return http.get(Uri.parse('$_baseUrlAPI/qotd'));
  }

  Future<void> getQuote() async {
    Response? response = await _getQuote();

    if (quote != null) {
      response = null;
      return;
    }

    if (response.statusCode == 200) {
      quote = Quote.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      await cacheQuote(quote!);
      notifyListeners();
    } else {
      throw Exception('Failed to load quote');
    }
  }
}
