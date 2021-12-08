// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quote _$QuoteFromJson(Map<String, dynamic> json) {
  return Quote(
    quoteDate: json['qotd_date'] as String,
    lastUpdated: DateTime.parse(json['last_updated'] as String),
    quote: json['quote'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$QuoteToJson(Quote instance) => <String, dynamic>{
      'qotd_date': instance.quoteDate,
      'last_updated': instance.lastUpdated.toIso8601String(),
      'quote': instance.quote,
    };
