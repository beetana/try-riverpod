// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CatFact {
  final String fact;
  final int length;

  CatFact({
    required this.fact,
    required this.length,
  });

  CatFact copyWith({
    String? fact,
    int? length,
  }) {
    return CatFact(
      fact: fact ?? this.fact,
      length: length ?? this.length,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fact': fact,
      'length': length,
    };
  }

  factory CatFact.fromMap(Map<String, dynamic> map) {
    return CatFact(
      fact: map['fact'] as String,
      length: map['length'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CatFact.fromJson(String source) => CatFact.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CatFact(fact: $fact, length: $length)';

  @override
  bool operator ==(covariant CatFact other) {
    if (identical(this, other)) return true;

    return other.fact == fact && other.length == length;
  }

  @override
  int get hashCode => fact.hashCode ^ length.hashCode;
}
