class AllChatModel {
  final String image;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadMessageCount;
  final bool isOnline;

  AllChatModel({
    required this.image,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadMessageCount,
    required this.isOnline,
  });

  // fromJson method
  factory AllChatModel.fromJson(Map<String, dynamic> json) {
    return AllChatModel(
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      lastMessage: json['lastMessage'] ?? '',
      time: json['time'] ?? '',
      unreadMessageCount: json['unreadMessageCount'] ?? 0,
      isOnline: json['isOnline'] ?? false,
    );
  }
}

