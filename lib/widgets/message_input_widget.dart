import 'package:flutter/material.dart';

class MessageInputWidget extends StatelessWidget {
  final TextEditingController controller;
  const MessageInputWidget({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        
         enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.green, width: 0.3), // Border color when not focused
        ),
        focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.green, width: 0.3), // Border color when focused
        ),
        hintText: "Type a message...",
      ),
    );
  }
}
