class Security {
  final String name;
  final String phoneNumber;
  final String isActive;

  const Security({
    required this.name,
    required this.phoneNumber,
    required this.isActive,
  });

  factory Security.fromJson(Map<String, dynamic> data) {
    return Security(
      name: data['nama'],
      phoneNumber: data['no_telp'],
      isActive: data['status_aktif'],
    );
  }
}
