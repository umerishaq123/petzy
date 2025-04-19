import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/controllers/chat_controller.dart';
import 'package:pet_app/models/chat_detail_model.dart';
import 'package:pet_app/models/user_model_firebase.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/images.dart';
import 'package:pet_app/widgets/chat_bubble_widget.dart';
import 'package:pet_app/widgets/message_input_widget.dart';

class ChatDetailScreen extends StatelessWidget {
  final bool? iscome;
  final String? name;
  final String? image;
  final UserModel? chatData;
  final String receiverId;
  
  ChatDetailScreen({super.key, this.chatData, required this.receiverId,this.iscome,this.name,this.image});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            children: [
              // Header Section
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back),
                  ),
                  SizedBox(width: 10.w),
                  CircleAvatar(
                    backgroundColor: blackColor,
                    radius: 20.r,
                    child: Image.network(
                   iscome==true?image??"":chatData?.image??"",
                      width: 40.w,
                      height: 40.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                    iscome==true?image??"":chatData?.image??"",
                          width: 40.w,
                          height: 40.h,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
           iscome==true?name??"" : chatData?.name??"",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Messages List
              Expanded(
                child: StreamBuilder<List<Message>>(
                  stream: controller.getMessagesStream(receiverId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    
                    if (snapshot.hasError) {
                      return Center(child: Text('Error loading messages'));
                    }
                    
                    final messages = snapshot.data ?? [];
                    
                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isTextMessage = message.messageType == MessageType.text;
                        final isMe = message.senderId == controller.currentUserId;
                        
                        return MessageBubble(
                          isImage: !isTextMessage,
                          isMe: isMe,
                          message: message,
                        );
                      },
                    );
                  },
                ),
              ),

              // Message Input Field at Bottom
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  children: [
                    Image.asset(galleryIcon, width: 15.w),
                    SizedBox(width: 10.w),
                    Image.asset(cameraIcon, width: 30.w),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: MessageInputWidget(
                        controller: controller.messageController,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    GestureDetector(
                      onTap: () => controller.sendMessage(receiverId),
                      child: Image.asset(sendIcon, width: 30.w),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}