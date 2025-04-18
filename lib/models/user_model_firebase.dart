import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String image;
  

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.image,

  });

  // Factory constructor to create a UserModel from Firestore data
  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      image: data['image'] ?? '',
     
    );
  }

  // Method to convert UserModel to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'image': image,
   
    };
  }
}
