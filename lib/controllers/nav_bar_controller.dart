import 'package:get/get.dart';

class NavController extends GetxController {
  var selectedIndex = 0.obs; // Observable index for active tab

  void changeTab(int index) {
    selectedIndex.value = index; // Update the active tab
  }
}