import 'package:get/get.dart';
import 'package:pet_app/models/user_model.dart';
import 'package:pet_app/utils/images.dart';

class HomeController extends GetxController{
  var isShareList = <bool>[].obs;
      final RxBool isUserSelected = false.obs;



 @override
  void onInit() {
    super.onInit();
    // Initialize your user data here or wherever you load it
    // Then initialize isShareList
    initializeShareList();
  }

  void initializeShareList() {
    isShareList.value = List.filled(user.value.followerList.length, false);
  }

  void shareChecked(int index, bool value) {
    if (index >= 0 && index < isShareList.length) {
      isShareList[index] = value;
      isShareList.refresh(); // Ensure UI updates
      isUserSelected.value = isShareList.contains(true);
      
    }
  }

 List<String>  posts=[
  pet1Icon,
  pet2Icon,
  pet13con,
    pet13con,
     pet2Icon,
  pet1Icon,
  pet1Icon,
  pet2Icon,
  pet13con,
   pet13con,
    pet13con,
     pet2Icon,
 

   
].obs;


   var user = Usermodelnew(
    name: 'katty_01',
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
    ], followerCount: 500, followerList: [
      Follower(profilePic: dummyImage, subtitle:" @Diamondruff", title:" Diamond_in_the_Ruff", isfollowing: false),
            Follower(profilePic: dummyImage, subtitle:" @Diamondruff", title:" Diamond_in_the_Ruff", isfollowing: true),
                  Follower(profilePic: dummyImage, subtitle:" @Diamondruff", title:" Diamond_in_the_Ruff", isfollowing: true),
    ], followingCount: 1202, location: 'islamabad behria', postcount: 555, issubscribed: false,
  ).obs; 

  

}