import 'package:json_annotation/json_annotation.dart';
part 'quote.g.dart';

@JsonSerializable(explicitToJson: true)
class Quote {
  const Quote({
    required this.quoteDate,
    required this.lastUpdated,
    required this.quote,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return _$QuoteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuoteToJson(this);
  }
  @JsonKey(name: 'qotd_date')
  final String quoteDate;

  @JsonKey(name: 'last_updated')
  final DateTime lastUpdated;

  final Map<String, dynamic> quote;

}
