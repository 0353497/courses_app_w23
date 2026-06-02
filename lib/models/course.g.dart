// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  start: Course._dateTimeFromJson(json['start'] as String),
  duration: Course._durationFromJson(json['duration'] as num),
  maxParticipants: (json['maxParticipants'] as num).toInt(),
  bookings: (json['bookings'] as List<dynamic>)
      .map((e) => Booking.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'start': Course._dateTimeToJson(instance.start),
  'duration': Course._durationToJson(instance.duration),
  'maxParticipants': instance.maxParticipants,
  'bookings': instance.bookings,
};
