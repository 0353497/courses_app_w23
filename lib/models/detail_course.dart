import 'package:courses_app/models/booking.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_course.g.dart';

@JsonSerializable()
class DetailCourse {
  final int id;
  final String title;
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime start;
  @JsonKey(fromJson: _durationFromJson, toJson: _durationToJson)
  final Duration duration;
  final int maxParticipants;
  final List<Booking> bookings;
  final String thumbnail;
  final String description;

  DetailCourse({
    required this.id,
    required this.title,
    required this.start,
    required this.duration,
    required this.maxParticipants,
    required this.bookings,
    required this.thumbnail,
    required this.description,
  });

  static DateTime _dateTimeFromJson(String v) => DateTime.parse(v);
  static String _dateTimeToJson(DateTime d) => d.toUtc().toIso8601String();

  static Duration _durationFromJson(num v) => Duration(minutes: v.toInt());
  static int _durationToJson(Duration d) => d.inMinutes;

  factory DetailCourse.fromJson(Map<String, dynamic> json) =>
      _$DetailCourseFromJson(json);
  Map<String, dynamic> toJson() => _$DetailCourseToJson(this);
}
