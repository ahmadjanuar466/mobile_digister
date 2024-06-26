class HousingModel {
  final String housingId;
  final String housingName;

  const HousingModel({
    required this.housingId,
    required this.housingName,
  });

  factory HousingModel.fromJson(Map<String, dynamic> data) {
    return HousingModel(
      housingId: data['id_perumahan'],
      housingName: data['nama_perumahan'],
    );
  }
}
