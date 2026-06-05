import 'package:courses_app/models/booking.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_course.g.dart';

enum CourseStatus { booked, onWaitingList, notBooked }

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

  bool get isInFuture => start.isAfter(DateTime.now());
  bool get isFullyBooked => bookings.length >= maxParticipants;

  List<Booking> get confirmedBookings {
    final sorted = _sortedBookings;
    return sorted.take(maxParticipants).toList();
  }

  List<Booking> get waitingList {
    final sorted = _sortedBookings;
    return sorted.skip(maxParticipants).toList();
  }

  List<Booking> get _sortedBookings =>
      [...bookings]..sort((a, b) => a.dateTime.compareTo(b.dateTime));

  CourseStatus statusForUser(int userId) {
    if (confirmedBookings.any((b) => b.userId == userId)) {
      return CourseStatus.booked;
    }
    if (waitingList.any((b) => b.userId == userId)) {
      return CourseStatus.onWaitingList;
    }
    return CourseStatus.notBooked;
  }
}
