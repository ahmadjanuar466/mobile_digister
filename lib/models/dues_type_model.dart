class DuesType {
  final String duesId;
  final String duesName;
  final String duesPrice;

  const DuesType({
    required this.duesId,
    required this.duesName,
    required this.duesPrice,
  });

  factory DuesType.fromJson(Map<String, dynamic> data) {
    return DuesType(
      duesId: data['id_jenis_iuran'],
      duesName: data['nama_jenis_iuran'],
      duesPrice: data['harga'],
    );
  }
}
