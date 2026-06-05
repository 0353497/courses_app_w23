import 'package:courses_app/models/booking.dart';
import 'package:courses_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/utils.dart';
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

  CourseStatus get statusForUser {
    final int userId = Get.find<UserProvider>().userId;
    if (confirmedBookings.any((b) => b.userId == userId)) {
      return CourseStatus.booked;
    }
    if (waitingList.any((b) => b.userId == userId)) {
      return CourseStatus.onWaitingList;
    }
    return CourseStatus.notBooked;
  }

  Color get getCourseColor {
    bool isInFuture = DateTime(2025, 6).isAfter(start);
    if (isInFuture) {
      if (statusForUser == CourseStatus.booked) return Colors.green;
      if (statusForUser == CourseStatus.onWaitingList) return Colors.yellow;
      if (statusForUser == CourseStatus.notBooked) return Colors.grey;
    } else {
      if (statusForUser == CourseStatus.booked) {
        return Colors.green.withAlpha(100);
      }
    }
    return Colors.grey.withAlpha(100);
  }
}

enum CourseStatus { booked, onWaitingList, notBooked }



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