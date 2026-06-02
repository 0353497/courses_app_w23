// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
  userId: (json['userId'] as num).toInt(),
  username: json['username'] as String,
  dateTime: Booking._dateTimeFromJson(json['bookedAt'] as String),
);

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
  'userId': instance.userId,
  'username': instance.username,
  'bookedAt': instance.dateTime.toIso8601String(),
};
