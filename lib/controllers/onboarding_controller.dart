import 'package:get/get.dart';
import 'package:pet_app/utils/images.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;

  final List<Map<String, String>> onboardingScreenData = [
    {
      'title': ' Welcome to PawzApp Where Pets Make Friends!',
      'subtitle':
          'A social space where pets and their humans connect, share, and have fun!',
      'imagePath': firstOnboarding,
    },
    {
      'title': 'A Social Haven for Pet Parents!',
      'subtitle':
          'Connect with fellow pet parents, find playmates, and share adorable moments.',
      'imagePath': secondOnboarding,
    },
    {
      'title': 'Share Cute Moments of your Pets',
      'subtitle':
          'Post photos, interact, and updates about your pet’s daily fun.',
      'imagePath': thirdOnboarding,
    },
  ];
}
