import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pet_app/models/pet_model.dart';

class ProfileController extends GetxController {
  // Use a map to store the state for each follower
  var followStates = <String, bool>{}.obs;

  void toggleFollowState(String followerId) {
    if (followStates.containsKey(followerId)) {
      followStates[followerId] = !followStates[followerId]!;
    } else {
      followStates[followerId] = true;
    }
  }

  @override
  void onInit() {
    super.onInit();

    // Fetch user's own posts when the controller is initialized
    fetchOwnPost();
  }

  bool isFollowing(String followerId) {
    return followStates[followerId] ?? false;
  }

  RxList<String> userPost = <String>[].obs;
  RxList<PetModel> petdata=<PetModel>[].obs;
  var isloading = false.obs;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> fetchOwnPost() async {
    try {
      isloading.value = true;
      final currentUserId = _firebaseAuth.currentUser?.uid;

      if (currentUserId == null) return;

      final querySnapshot = await _firebaseFirestore
          .collection("pet")
          .where('uid', isEqualTo: currentUserId)
          .get();

      final List<String> imageUrls = [];

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        petdata.add(PetModel.fromJson(data));
        // Assuming 'images' is a List<dynamic> of URLs
        if (data.containsKey('images') && data['images'] is List) {
          imageUrls.addAll(List<String>.from(data['images']));
        }
      }

      userPost.assignAll(imageUrls);
      isloading.value =
          false; // Example RxList<String> yourImageListVariable = <String>[].obs;
    } catch (error) {
      isloading.value = false;
      print('Error fetching own posts: $error');
    } finally {
      isloading.value = false;
    }
  }
}
