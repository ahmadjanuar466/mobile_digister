class CCTV {
  final String blockName;
  final String url;
  final int isActive;

  const CCTV({
    required this.blockName,
    required this.url,
    required this.isActive,
  });

  factory CCTV.fromJson(Map<String, dynamic> data) {
    return CCTV(
      blockName: data['nama_blok'],
      url: data['url'],
      isActive: int.parse(data['is_active']),
    );
  }
}
