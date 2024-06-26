class SecurityModel {
  final String name;
  final String phoneNumber;
  final String isActive;

  const SecurityModel({
    required this.name,
    required this.phoneNumber,
    required this.isActive,
  });

  factory SecurityModel.fromJson(Map<String, dynamic> data) {
    return SecurityModel(
      name: data['nama'],
      phoneNumber: data['no_telp'],
      isActive: data['status_aktif'],
    );
  }
}
