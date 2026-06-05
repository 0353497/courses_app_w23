// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailCourse _$DetailCourseFromJson(Map<String, dynamic> json) => DetailCourse(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  start: DetailCourse._dateTimeFromJson(json['start'] as String),
  duration: DetailCourse._durationFromJson(json['duration'] as num),
  maxParticipants: (json['maxParticipants'] as num).toInt(),
  bookings: (json['bookings'] as List<dynamic>)
      .map((e) => Booking.fromJson(e as Map<String, dynamic>))
      .toList(),
  thumbnail: json['thumbnail'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$DetailCourseToJson(DetailCourse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'start': DetailCourse._dateTimeToJson(instance.start),
      'duration': DetailCourse._durationToJson(instance.duration),
      'maxParticipants': instance.maxParticipants,
      'bookings': instance.bookings,
      'thumbnail': instance.thumbnail,
      'description': instance.description,
    };
