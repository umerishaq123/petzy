import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/models/pet_model.dart';
import 'package:pet_app/utils/cloudnary_data.dart';
import 'package:pet_app/utils/constants.dart';
import 'package:pet_app/utils/images.dart';
import 'package:pet_app/utils/snackbar_utilis.dart';
import 'package:pet_app/views/posts/add_post_screen.dart';
import 'package:uuid/uuid.dart';
class AddPetPostController extends GetxController {
  var isLoading=false.obs;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  TextEditingController petNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController country = TextEditingController();

  var selectedImages = <File>[].obs;

  CloudnaryData _cloudnaryData = CloudnaryData();

//for images
 
  RxInt currentImageIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with your image list
    // postImages.addAll([post1Icon, post2Icon]);
  }

  void setCurrentImage(int index) {
    currentImageIndex.value = index;
  }

  //image picker
  final RxString pickedImagePath = ''.obs;

  // Store selected images

  Future<void> pickImagesFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      selectedImages.value = result.paths.map((path) => File(path!)).toList();
    }
  }

  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      pickedImagePath.value = image.path;
    }
  }

//for
  RxString selectedbreed = ''.obs;
  RxString selectedGender = ''.obs;
  RxString selectedHeight = ''.obs;
  RxString selectedWeight = ''.obs;

  final List<String> height = ['20 ft', '30ft', '40ft'];
  final List<String> weightList = ['10w', '20w', '30w'];
  final List<String> breedList = ['Husky', 'Germen', 'Other'];
  final List<String> genderList = ['Male', 'Female', 'Other'];

  void selectTpe(String type) {
    selectedbreed.value = type;
    update();
  }

  void selectGender(String gender) {
    selectedGender.value = gender;
    update();
  }

  void selectHeight(String value) {
    selectedHeight.value = value;
    update();
  }

  void selectWeight(String value) {
    selectedWeight.value = value;
    update();
  }

Future<void> addPetPost(BuildContext context) async {
  try {
    isLoading.value=true;

    // Upload multiple images
    List<String>? mulitipleimageUrl;
    if (selectedImages.isNotEmpty) {
      mulitipleimageUrl = await _cloudnaryData.uploadMultipleImages(selectedImages, context);
    }

    

    // Validate and parse age
 
FirebaseAuth firebaseAuth=FirebaseAuth.instance;
final uid=firebaseAuth.currentUser?.uid??"";
    // Construct PetModel
      final docId = Uuid().v4();
      final posturl="$postLink/$docId";
    PetModel petModel = PetModel(
      petName: petNameController.text.trim(),
      petType: selectedbreed.value,
      breed: "",
      gender: selectedGender.value,
      age: ageController.text.trim(),
      color: colorController.text.trim(),
      height: selectedHeight.value,
      weight: selectedWeight.value,
      images: mulitipleimageUrl ?? [],
      description: description.text.trim(),
      countryName: country.text.trim(), uid:uid,
       postLink: posturl.trim(),   createdAt: DateTime.now(),   postId: docId,
    );

    // Firestore upload
  
    await FirebaseFirestore.instance.collection("pet").doc(docId).set(petModel.toJson());
  disposeFields();

    // Navigate back
    Get.off(AddPostScreen());
    SnackbarUtils.showCustomSnackbar(title: "Success", message: "Pet post added successfully");
    isLoading.value=false;

  } catch (error) {
  isLoading.value=false;

    if (error is FirebaseException) {
      isLoading.value=false;
      SnackbarUtils.showCustomSnackbar(title: "Firestore Error", message: error.message ?? "Unknown error");
    } else {
      isLoading.value=false;
      SnackbarUtils.showCustomSnackbar(title: "Error", message: error.toString());
    }
  }
}

void disposeFields() {
  // Clear text controllers
  petNameController.clear();
  ageController.clear();
  colorController.clear();
 description.clear();
  country.clear();

  // Clear image selections
  selectedImages.clear();
  pickedImagePath.value = '';

  // Reset dropdown selections
  selectedbreed.value = '';
  selectedGender.value = '';
  selectedHeight.value = '';
  selectedWeight.value = '';
  
  // Reset image index if needed
  currentImageIndex.value = 0;

  // Optional: call update() if you want to trigger a UI update
  update();
}

}
