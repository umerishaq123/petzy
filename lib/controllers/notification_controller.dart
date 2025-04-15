import 'package:get/get.dart';
import 'package:pet_app/models/notification_model.dart';
import 'package:pet_app/utils/images.dart';

class NotificationController extends GetxController{
  List<NotificationModel> notificationData=[
    NotificationModel(postImage:   pet2Icon, profilePic: dummyImage, subtitle: "abc", time: "53sec", title: "PurMeow, commented “That face could melt hearts! 😍” 52m"),
        NotificationModel(postImage:   pet2Icon, profilePic: dummyImage, subtitle: "abc", time: "53sec", title: "PurMeow, commented “That face could melt hearts! 😍” 52m"),
    NotificationModel(postImage:   pet2Icon, profilePic: dummyImage, subtitle: "abc", time: "53sec", title: "PurMeow, commented “That face could melt hearts! 😍” 52m",isfollow: true),

  ].obs;
}