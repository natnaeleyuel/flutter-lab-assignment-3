class AlbumModel {
  final int id;
  final int userId;
  final String title;

  AlbumModel({
    required this.id,
    required this.userId,
    required this.title,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
    };
  }
}