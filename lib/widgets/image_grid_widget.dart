import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ImageGridWidget extends StatelessWidget {
  const ImageGridWidget({super.key});

  final List<String> images = const [
    'assets/images/pet_1.jpeg',
    'assets/images/pet_2.jpeg',
    'assets/images/pet_3.jpeg',
    'assets/images/pet_4.jpeg',
    'assets/images/pet_5.jpeg',
    'assets/images/pet_6.jpeg',
    'assets/images/pet_7.jpeg',
    'assets/images/pet_8.jpeg',
    'assets/images/pet_9.jpeg',
    'assets/images/pet_10.jpeg',
    'assets/images/pet_11.jpeg',
    'assets/images/pet_12.jpeg',
    'assets/images/pet_13.jpeg',
    'assets/images/pet_14.jpeg',
    'assets/images/pet_15.jpeg',
    'assets/images/pet_16.jpeg'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: MasonryGridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.asset(
              images[index],
              fit: BoxFit.cover,
              height: (index % 5 == 0 || index % 4 == 0) ? 180.h : 100.h,
              width: double.infinity,
            ),
          );
        },
      ),
    );
  }
}
