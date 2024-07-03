class CCTV {
  final String url;
  final int isActive;

  const CCTV({
    required this.url,
    required this.isActive,
  });

  factory CCTV.fromJson(Map<String, dynamic> data) {
    return CCTV(
      url: data['url'],
      isActive: int.parse(data['is_active']),
    );
  }
}
