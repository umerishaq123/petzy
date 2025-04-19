// edit_post_controller.dart
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/models/pet_model.dart';
import 'package:pet_app/utils/cloudnary_data.dart';
import 'package:pet_app/utils/snackbar_utilis.dart';

class EditPostController extends GetxController {
  // Text Controllers
  TextEditingController petNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController country = TextEditingController();

  // Image carousel
  RxInt currentImageIndex = 0.obs;
  void setCurrentImage(int index) => currentImageIndex.value = index;

  // Dropdowns
  RxString selectedbreed = ''.obs;
  RxString selectedGender = ''.obs;
  RxString selectedHeight = ''.obs;
  RxString selectedWeight = ''.obs;

  final List<String> height = ['20 ft', '30ft', '40ft'];
  final List<String> weightList = ['10w', '20w', '30w'];
  final List<String> breedList = ['Husky', 'Germen', 'Other'];
  final List<String> genderList = ['Male', 'Female', 'Other'];

  void selectTpe(String type) => selectedbreed.value = type;
  void selectGender(String gender) => selectedGender.value = gender;
  void selectHeight(String value) => selectedHeight.value = value;
  void selectWeight(String value) => selectedWeight.value = value;

  // Image handling
  var selectedImageUrls = <String>[].obs;
  var selectedImages = <File>[].obs;

  // Picking new images
Future<void> pickImagesFromGallery() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: true,
  );

  if (result != null) {
    final files = result.paths.map((path) => File(path!)).toList();
    selectedImages.assignAll(files);
    currentImageIndex.value = 0;
  }
}
  final firebaseFirestore = FirebaseFirestore.instance;
  var postData = Rx<PetModel?>(null);

  @override
  void onInit() {
    super.onInit();
  }

  // Fetch document and populate model
  Future<void> fetchPostData(String docId) async {
    try {
      DocumentSnapshot snapshot =
          await firebaseFirestore.collection('pet').doc(docId).get();

      if (snapshot.exists) {
        postData.value =
            PetModel.fromJson(snapshot.data() as Map<String, dynamic>);
        await loadData();
      } else {
        print("Document does not exist.");
        postData.value = null;
      }
    } catch (error) {
      print("🔥 Error fetching post: $error");
      throw Exception(error.toString());
    }
  }

  // Load controller values from model
  Future<void> loadData() async {
    if (postData.value != null) {
      petNameController.text = postData.value!.petName ?? "";
      ageController.text = postData.value!.age;
      colorController.text = postData.value!.color;
      description.text = postData.value!.description;
      country.text = postData.value!.countryName;

      selectedbreed.value = postData.value!.petType;
      selectedGender.value = postData.value!.gender;
      selectedHeight.value = postData.value!.height;
      selectedWeight.value = postData.value!.weight;

      if (postData.value!.images != null) {
        selectedImageUrls.assignAll(postData.value!.images!);
      }
    } else {
      print("⚠️ Pet data is null, cannot load fields.");
    }
  }


var isloadingUpdate=false.obs;
  // Update post in Firestore
final cloudinary = CloudnaryData();

Future<void> updatePost(String docId, BuildContext context) async {
  print("::: the name is here: ${petNameController.text}");
  try {
    isloadingUpdate.value = true;

    List<String> imageUrls = [];

    // Upload new images if selectedImages is not empty
    if (selectedImages.isNotEmpty) {
      imageUrls = await cloudinary.uploadMultipleImages(selectedImages, context);
    } else {
      // If no new images selected, retain old ones
      imageUrls = selectedImageUrls;
    }

    var dataToUpdate = {
      'petName': petNameController.text,
      'age': ageController.text,
      'color': colorController.text,
      'description': description.text,
      'countryName': country.text,
      'breed': selectedbreed.value,
      'gender': selectedGender.value,
      'height': selectedHeight.value,
      'weight': selectedWeight.value,
      'images': imageUrls,
    };

    print("📝 Updating post with data: $dataToUpdate");

    await firebaseFirestore.collection('pet').doc(docId).update(dataToUpdate);

    Get.back();
    SnackbarUtils.showCustomSnackbar(
      title: "Success",
      message: "Post updated successfully",
    );
    isloadingUpdate.value = false;
  } catch (error) {
    isloadingUpdate.value = false;
    print("❌ Error updating post: $error");
    SnackbarUtils.showCustomSnackbar(title: "Error", message: error.toString());
    throw Exception(error.toString());
  }
}


}