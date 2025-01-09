import 'package:equatable/equatable.dart';

class Diary extends Equatable {
  final int? id; 
  final int? userId; 
  final String? content; 
  final String? emotion; 
  final String? suggestionsAi; 
  final String? quote;  
  final int? stressLevel;  
  final bool? isProcessed; 
  final DateTime? createdAt;  
  final DateTime? updatedAt; 

  const Diary({
    this.id,
    this.userId,
    this.content,
    this.emotion,
    this.suggestionsAi,
    this.quote,
    this.stressLevel,
    this.isProcessed,
    this.createdAt,
    this.updatedAt,
  });

  factory Diary.fromJson(Map<String, dynamic> json) => Diary(
        id: json['id'] as int?,
        userId: json['user_id'] as int?,
        content: json['content'] as String?,
        emotion: json['emotion'] as String?,
        suggestionsAi: json['suggestions_ai'] as String?,
        quote: json['quote'] as String?,
        stressLevel: json['stress_level'] as int?,
        isProcessed: json['is_processed'] as bool?,
        createdAt: DateTime.tryParse(json['created_at'] ?? ''),
        updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'content': content,
        'emotion': emotion,
        'suggestions_ai': suggestionsAi,
        'quote': quote,
        'stress_level': stressLevel,
        'is_processed': isProcessed,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        userId,
        content,
        emotion,
        suggestionsAi,
        quote,
        stressLevel,
        isProcessed,
        createdAt,
        updatedAt,
      ];
}
