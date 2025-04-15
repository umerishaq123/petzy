import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String image;
  final bool isOnline;
  final String lastMessage;
  final String time;
  final int unreadMessageCount;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.image,
    required this.isOnline,
    required this.lastMessage,
    required this.time,
    required this.unreadMessageCount,
    required this.createdAt,
  });

  // Factory constructor to create a UserModel from Firestore data
  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      image: data['image'] ?? '',
      isOnline: data['isOnline'] ?? false,
      lastMessage: data['lastMessage'] ?? '',
      time: data['time'] ?? '',
      unreadMessageCount: data['unreadMessageCount'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // Method to convert UserModel to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'image': image,
      'isOnline': isOnline,
      'lastMessage': lastMessage,
      'time': time,
      'unreadMessageCount': unreadMessageCount,
      'createdAt': createdAt,
    };
  }
}
