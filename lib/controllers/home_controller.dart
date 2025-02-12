import 'package:get/get.dart';
import 'package:pet_app/models/user_model.dart';
import 'package:pet_app/utils/images.dart';

class HomeController extends GetxController{




   var user = Usermodel(
    name: 'Jack',
    profile: dummyImage,
    feedData: [
      FeedModel(
        createdAt: '10h ago',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit quisque',
        image: "dummyImage",
        petName: '@katty_01', postImage: post1Icon,
      ),
      FeedModel(
        createdAt: '10h ago',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit quisque',
        image: dummyImage,
        petName: 'Buddy', postImage: post2Icon,
      ),
    ],
  ).obs; 

}