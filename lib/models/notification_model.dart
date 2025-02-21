class NotificationModel {
  final String profilePic;
  final String title;
  final String subtitle;
  final String time;
  final String postImage;
  final bool? isfollow;

  NotificationModel(
      {required this.postImage,
      required this.profilePic,
      required this.subtitle,
      required this.time,
      required this.title,
    this.isfollow=false});
}
