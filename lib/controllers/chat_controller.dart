import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/models/chat_detail_model.dart';
import 'package:pet_app/models/user_model_firebase.dart';
import 'package:pet_app/utils/snackbar_utilis.dart';

class ChatController extends GetxController {
  TextEditingController messageController = TextEditingController();
  List<UserModel> chatList = <UserModel>[].obs;
  List<Message> messages = <Message>[].obs;

  static final firestore = FirebaseFirestore.instance;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void onInit() {
    super.onInit();
    getChatList();
  }

  Future<void> getChatList() async {
    try {
      firestore.collection("users").snapshots().listen((snapshot) {
        chatList.assignAll(
          snapshot.docs.map((doc) => UserModel.fromFirestore(doc.data())).toList(),
        );
      });
    } catch (error) {
      print("Error fetching chat list: $error");
    }
  }

  Stream<List<Message>> getMessagesStream(String receiverId) {
    return firestore
        .collection('users')
        .doc(currentUserId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('sentTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Message.fromJson(doc.data()))
            .toList());
  }

  Future<void> sendMessage(String receiverId) async {
    try {
      if (messageController.text.isEmpty) {
        SnackbarUtils.showCustomSnackbar(title: "Error", message: "Message cannot be empty");
        return;
      }

      final message = Message(
        senderId: currentUserId!,
        receiverId: receiverId,
        content: messageController.text.trim(),
        sentTime: DateTime.now(),
        messageType: MessageType.text,
      );

      // Add message to sender's chat
      await firestore
          .collection('users')
          .doc(currentUserId)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .add(message.toJson());

      // Add message to receiver's chat
      await firestore
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(currentUserId)
          .collection('messages')
          .add(message.toJson());

      messageController.clear();
    } catch (error) {
      SnackbarUtils.showCustomSnackbar(title: "Error", message: error.toString());
    }
  }
}