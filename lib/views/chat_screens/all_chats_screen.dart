import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/controllers/chat_controller.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/views/chat_screens/chat_detail_Screen.dart';
import 'package:pet_app/widgets/custom_chat_item_widget.dart';
import 'package:pet_app/widgets/custom_search_widget.dart';

class AllChatsScreen extends StatelessWidget {
  const AllChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller=Get.isRegistered()?Get.find<ChatController>():Get.put(ChatController(),permanent: true);
   controller.getChatList();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){

        }, icon: Icon(Icons.arrow_back)),
        title: Text("Messages",
         style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500
          ),),
          centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w),
            child: CustomSearchWidget(),
          ),
          SizedBox(height: 10.h,),
         Obx((){
          return  Expanded(
            child:
             ListView.builder(
              itemCount: controller.chatList.length,
              itemBuilder: (context,index){
                final allChatData=controller.chatList[index];
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                child: Column(
                  children: [
                    // GestureDetector(
                    //   onTap: (){
                    //     Get.to(()=>ChatDetailScreen(chatData: allChatData, receiverId: allChatData.uid,));
                    //   },
                      // child: CustomChatItemWidget(chatData: allChatData, index: index,)),
                    Divider(color: blackColor.withOpacity(0.1),)
                  ],
                ),
              );
            }),
          );
       
       
         })
         
       
        ],),
      ),
    );
  }
}