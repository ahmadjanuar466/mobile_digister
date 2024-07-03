class User {
  final String userId;
  final String nik;
  final String nama;
  final String block;
  final String phoneNum;
  final String houseNum;
  final String housingId;
  final int isActive;
  final String email;
  final String housingName;

  const User({
    required this.userId,
    required this.nik,
    required this.nama,
    required this.block,
    required this.phoneNum,
    required this.houseNum,
    required this.housingId,
    required this.isActive,
    required this.email,
    required this.housingName,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      userId: data['id'],
      nik: data['nik'],
      nama: data['nama'],
      block: data['blok'],
      phoneNum: data['no_telp'],
      houseNum: data['no_rumah'],
      housingId: data['id_perumahan'],
      isActive: int.parse(data['is_active']),
      email: data['email'],
      housingName: data['nama_perumahan'],
    );
  }
}
