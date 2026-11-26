import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

/// Portfolio experience synchronized with the Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Experience {
  const Experience({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    this.categoryDisplay = '',
    this.thumbnail,
    this.startedAt,
    this.endedAt,
    this.isOngoing = true,
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  /// Set by the server (UUID), so it is never sent in a request body.
  @JsonKey(includeToJson: false)
  final String? id;

  final String title;
  final String description;

  /// Lowercase API value: internship, research, volunteer, part-time,
  /// full-time, or freelance.
  final String category;

  /// Human-readable label computed by the server (read-only).
  @JsonKey(includeToJson: false, defaultValue: '')
  final String categoryDisplay;

  /// Optional image URL. The API accepts and returns null when empty.
  final String? thumbnail;

  /// Set automatically by the server when the entry is created (read-only).
  @JsonKey(includeToJson: false)
  final DateTime? startedAt;

  /// Optional end date. Null means the experience is still ongoing.
  final DateTime? endedAt;

  /// Computed by the server from [endedAt] (read-only).
  @JsonKey(includeToJson: false, defaultValue: true)
  final bool isOngoing;

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}
