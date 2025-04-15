class Usermodelnew {
  final String name;
  final String profile;
  final String location;
  final int postcount;
  final int followerCount;
  final int followingCount;
  final List<FeedModel> feedData;
  final List<Follower> followerList;
  final bool issubscribed;

  Usermodelnew(
      {required this.feedData,
      required this.name,
      required this.profile,
      required this.followerCount,
      required this.followerList,
      required this.followingCount,
      required this.location,
      required this.postcount,
      required this.issubscribed});
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

class Follower {
  final String profilePic;
  final String title;
  final String subtitle;
  final bool isfollowing;
  Follower(
      {required this.profilePic,
      required this.subtitle,
      required this.title,
      required this.isfollowing});
}
