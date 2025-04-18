class PetModel {
  final String uid;
  final String postId;
  final String petName;
  final String petType;
  final String breed;
  final String gender;
  final String age;
  final String color;
  final String height;
  final String weight;
  final List<String> images;
  final String description;
  final String countryName;
  final String postLink;
  final DateTime createdAt; // <-- New field added

  PetModel({
    required this.uid,
       required this.postId,
    required this.petName,
    required this.petType,
    required this.breed,
    required this.gender,
    required this.age,
    required this.color,
    required this.height,
    required this.weight,
    required this.images,
    required this.description,
    required this.countryName,
    required this.postLink,
    required this.createdAt, // <-- Include in constructor
  });

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      uid: json['uid'] ?? "",
      postId: json['postId']??"",
      petName: json['petName'] ?? '',
      petType: json['petType'] ?? '',
      breed: json['breed'] ?? '',
      gender: json['gender'] ?? '',
      age: json['age'] ?? "",
      color: json['color'] ?? '',
      height: json['height'] ?? '',
      weight: json['weight'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      description: json['description'] ?? '',
      countryName: json['countryName'] ?? '',
      postLink: json['postLink'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(), // <-- Safe parse
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "postId": postId,
      'petName': petName,
      'petType': petType,
      'breed': breed,
      'gender': gender,
      'age': age,
      'color': color,
      'height': height,
      'weight': weight,
      'images': images,
      'description': description,
      'countryName': countryName,
      "postLink": postLink,
      "createdAt": createdAt.toIso8601String(), // <-- Convert to string
    };
  }
}
