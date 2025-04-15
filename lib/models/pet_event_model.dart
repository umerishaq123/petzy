class PetEventModel {
  final String image;
  final DateTime date;
  final String eventDate;
  final String location;
  final String eventTitle;

  PetEventModel({
    required this.image,
    required this.date,
    required this.eventDate,
    required this.location,
    required this.eventTitle
  });

  factory PetEventModel.fromJson(Map<String, dynamic> json) {
    return PetEventModel(
      image: json['image'] ?? '',
      date: DateTime.parse(json['date']),
      eventDate: json['eventDate'] ?? '',
      location: json['location'] ?? '',
      eventTitle: json['eventTitle']??""
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'date': date.toIso8601String(),
      'eventDate': eventDate,
      'location': location,
      'eventTitle':eventTitle
    };
  }
}
