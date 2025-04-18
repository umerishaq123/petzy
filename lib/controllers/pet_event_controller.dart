import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/models/pet_event_model.dart';
import 'package:pet_app/utils/images.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
class PetEventController extends GetxController {
TextEditingController countryController=TextEditingController();



  List<PetEventModel> peteventList = <PetEventModel>[].obs;



  

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchEventList();
  }

  void fetchEventList() {
    try {
      List<PetEventModel> data = [
        PetEventModel(
            image: pet2Icon,
            date: DateTime.now(),
            eventDate: '25/3/2026',
            location: 'Abboottabad',
            eventTitle: "big show"),
        PetEventModel(
            image: pet1Icon,
            date: DateTime.now(),
            eventDate: '25/3/2026',
            location: 'Islamabad',
            eventTitle: "pet show"),
        PetEventModel(
            image: petIcon,
            date: DateTime.now(),
            eventDate: '25/3/2026',
            location: 'location',
            eventTitle: "hello pets"),
      ];
      peteventList.addAll(data);
    } catch (error) {
      print(":::::: the error :${error}");
    }
  }
}
