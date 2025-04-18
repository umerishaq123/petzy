import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet_app/models/pet_model.dart';
import 'package:pet_app/models/user_model.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/images.dart';
import 'package:pet_app/utils/snackbar_utilis.dart';

class HomeController extends GetxController{
  var isShareList = <bool>[].obs;
      final RxBool isUserSelected = false.obs;



 @override
  void onInit() {
    super.onInit();
    // Initialize your user data here or wherever you load it
    // Then initialize isShareList
    fetchAllPost();
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

  
//
List<PetModel>  postList=<PetModel>[].obs;
FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
var isloading=false.obs;
var isloadingDelete=false.obs;


Future<void> fetchAllPost() async {
  try {
    isloading.value = true;

    // Get all documents from 'pet' collection
    final querySnapshot = await firebaseFirestore.collection('pet').get();

    // Convert each document into a PetModel and add to postList
final data= querySnapshot.docs.map((doc) {
      return PetModel.fromJson(doc.data()); // Assuming you have fromJson()
    }).toList();
    postList.clear();
    postList.addAll(data);


    isloading.value = false;
  } catch (error) {
    isloading.value = false;
    print("The error in fetchAllPost is: $error");
    throw Exception(error.toString());
  }
}



Future<void> deletePost(String docId,context)async{
  try{
    isloadingDelete.value=true;
    await firebaseFirestore.collection('pet').doc(docId).delete();


   
   navigator?.pop(context);
     SnackbarUtils.showCustomSnackbar(title: "Success", message: "Post is Deleted Sucessfully");

    isloading.value = false;
  }catch(error){
    
    SnackbarUtils.showCustomSnackbar(title: "Error", message: "Post is Deleted failed",backgroundColor: redColor);
    isloading.value = false;
    print("The error in fetchAllPost is: $error");
    throw Exception(error.toString());
  }
}
}