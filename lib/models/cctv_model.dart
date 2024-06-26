class CCTVModel {
  final String url;
  final int isActive;

  const CCTVModel({
    required this.url,
    required this.isActive,
  });

  factory CCTVModel.fromJson(Map<String, dynamic> data) {
    return CCTVModel(
      url: data['url'],
      isActive: int.parse(data['is_active']),
    );
  }
}
