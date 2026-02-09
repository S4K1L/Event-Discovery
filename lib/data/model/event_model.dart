class EventModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  final DateTime date;
  final String startTime;
  final String endTime;

  final int totalSeats;
  final int bookedSeats;

  final double price;
  final double? totalEarnings;

  final String organizerName;

  final String locationName;
  final String locationAddress;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.totalSeats,
    required this.bookedSeats,
    required this.price,
    this.totalEarnings,
    required this.organizerName,
    required this.locationName,
    required this.locationAddress,
  });

  /// Seats left
  int get availableSeats => totalSeats - bookedSeats;

  /// Formatted seat text (10/40 seats)
  String get seatText => "$bookedSeats/$totalSeats";

  /// Formatted date (21/03/2025)
  String get formattedDate =>
      "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";

  /// Time range text
  String get timeRange => "$startTime - $endTime";

  /// JSON factory (for API)
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
      date: DateTime.parse(json['date']),
      startTime: json['start_time'],
      endTime: json['end_time'],
      totalSeats: json['total_seats'],
      bookedSeats: json['booked_seats'],
      price: (json['price'] as num).toDouble(),
      totalEarnings: (json['totalEarnings'] as num).toDouble(),
      organizerName: json['organizer_name'],
      locationName: json['location_name'],
      locationAddress: json['location_address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "image_url": imageUrl,
      "date": date.toIso8601String(),
      "start_time": startTime,
      "end_time": endTime,
      "total_seats": totalSeats,
      "booked_seats": bookedSeats,
      "price": price,
      "totalEarnings": totalEarnings,
      "organizer_name": organizerName,
      "location_name": locationName,
      "location_address": locationAddress,
    };
  }
}
