import 'package:get/get.dart';

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

  bool isFollowing(String followerId) {
    return followStates[followerId] ?? false;
  }
}