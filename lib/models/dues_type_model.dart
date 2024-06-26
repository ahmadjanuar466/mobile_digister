class DuesTypeModel {
  final String duesId;
  final String duesName;
  final String duesPrice;

  const DuesTypeModel({
    required this.duesId,
    required this.duesName,
    required this.duesPrice,
  });

  factory DuesTypeModel.fromJson(Map<String, dynamic> data) {
    return DuesTypeModel(
      duesId: data['id_jenis_iuran'],
      duesName: data['nama_jenis_iuran'],
      duesPrice: data['harga'],
    );
  }
}
