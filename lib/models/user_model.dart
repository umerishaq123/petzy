class Usermodel {
  final String name;
  final String profile;
  final List<FeedModel> feedData;

  Usermodel(
      {required this.feedData, required this.name, required this.profile});
}

class FeedModel {
  final String postImage;
  final String image;
  final String petName;
  final String createdAt;
  final String description;

  FeedModel(
      {required this.postImage,
        required this.createdAt,
      required this.description,
      required this.image,
      required this.petName});
}
