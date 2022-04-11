import 'dart:convert';

import 'package:affirmation_gratitude/core/utilities/prefs_string.dart';
import 'package:affirmation_gratitude/model/quote.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuotesNetwork with ChangeNotifier {
  QuotesNetwork();

  Quote? quote;
  bool? isSelected;

  final String _baseUrlAPI = 'https://favqs.com/api';

  static int _retryCount = 0;
  static const int _thresholdLimit = 5;

  Future<void> getQuote() async {
    Response? response = await http.get(Uri.parse('$_baseUrlAPI/qotd'));

    final _quote = jsonDecode(response.body) as Map<String, dynamic>;

    if (_authorIsNullOrEmpty(_quote) ||
        _dateIsNullOrEmpty(_quote) ||
        _textBodyIsNullOrEmpty(_quote)) {
      if (_timedOut() == true) return;
      _retryCount++;
      await getQuote();
      return;
    }

    if (quote != null) {
      response = null;
      return;
    }

    if (response.statusCode == 200) {
      final Quote? _cachedQuote = await getCachedQuote();
      if (_cachedQuote == null) {
        await _cacheQuote(_quote);
        return;
      }

      if (_shouldUpdateQuote(_cachedQuote.lastUpdated)) {
        await _cacheQuote(_quote);
        return;
      }

      quote = await getCachedQuote();
      isSelected = await getCachedFavouredQuote();
      notifyListeners();
    } else {
      throw Exception('Failed to load quote');
    }
  }

  Future<bool?> getCachedFavouredQuote() async {
    final SharedPreferences prefs =  await SharedPreferences.getInstance();

  }

  Future<Quote?> getCachedQuote() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cachedQuoteString = prefs.getString(PrefsString.quote);

    if (cachedQuoteString == null) return null;
    final quoteMap = jsonDecode(cachedQuoteString) as Map<String, dynamic>;

    return Quote.fromJson(quoteMap);
  }

  Future<void> _cacheQuote(Map<String, dynamic> _quote) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _addLastUpdatedDate(_quote);

    await prefs.setString(PrefsString.quote, jsonEncode(_quote));

    quote = Quote.fromJson(_quote);

    notifyListeners();
  }

  bool _shouldUpdateQuote(DateTime lastUpdated) {
    final DateTime now = DateTime.now();
    final Duration hoursMinutesSeconds = Duration(
      hours: now.hour,
      minutes: now.minute,
      seconds: now.second,
      milliseconds: now.millisecond,
    );
    final DateTime date = now.subtract(hoursMinutesSeconds);

    return lastUpdated.isBefore(date);
  }

  void _addLastUpdatedDate(Map<String, dynamic> _quote) {
    _quote.addAll(<String, dynamic>{
      PrefsString.lastUpdated: DateTime.now().toString(),
    });
  }

  bool _authorIsNullOrEmpty(Map<String, dynamic> _quote) {
    final String? _author = _quote['quote']['author'] as String?;
    return _author == null || _author.isEmpty;
  }

  bool _dateIsNullOrEmpty(Map<String, dynamic> _quote) {
    final String? _date = _quote['qotd_date'] as String?;
    return _date == null || _quote.isEmpty;
  }

  bool _textBodyIsNullOrEmpty(Map<String, dynamic> _quote) {
    final String? _textBody = _quote['quote']['body'] as String?;
    return _textBody == null || _textBody.isEmpty;
  }

  bool _timedOut() {
    return _retryCount >= _thresholdLimit;
  }
}
