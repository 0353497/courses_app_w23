import 'package:json_annotation/json_annotation.dart';
part 'booking.g.dart';

@JsonSerializable()
class Booking {
  final int userId;
  final String username;
  @JsonKey(fromJson: _dateTimeFromJson, name: "bookedAt")
  final DateTime dateTime;

  Booking({
    required this.userId,
    required this.username,
    required this.dateTime,
  });

  static DateTime _dateTimeFromJson(String v) {
    return DateTime.parse(v);
  }

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
