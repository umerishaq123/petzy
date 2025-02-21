import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pet_app/utils/images.dart';

class PostImageController extends GetxController {
  RxList<String> postImages = <String>[].obs;
  RxInt currentImageIndex = 0.obs;
  
  @override
  void onInit() {
    super.onInit();
    // Initialize with your image list
    postImages.addAll([post1Icon, post2Icon]);
  }
  
  void setCurrentImage(int index) {
    currentImageIndex.value = index;
  }
}