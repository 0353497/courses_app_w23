import 'package:courses_app/models/booking.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  final int id;
  final String title;
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime start;
  @JsonKey(fromJson: _durationFromJson, toJson: _durationToJson)
  final Duration duration;
  final int maxParticipants;
  final List<Booking> bookings;
  DateTime get end => start.add(duration);

  Course({
    required this.id,
    required this.title,
    required this.start,
    required this.duration,
    required this.maxParticipants,
    required this.bookings,
  });

  static DateTime _dateTimeFromJson(String v) => DateTime.parse(v);
  static String _dateTimeToJson(DateTime d) => d.toUtc().toIso8601String();

  static Duration _durationFromJson(num v) => Duration(minutes: v.toInt());
  static int _durationToJson(Duration d) => d.inMinutes;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}





// {
//       "id": 127,
//       "title": "Morning Yoga",
//       "start": "2025-05-26T07:00:00.000Z",
//       "duration": 60,
//       "bookings": [
//         {
//           "userId": 22,
//           "username": "victoria",
//           "bookedAt": "2025-06-02T13:00:00.000Z"
//         },
//       ],
//       "maxParticipants": 20
//     },