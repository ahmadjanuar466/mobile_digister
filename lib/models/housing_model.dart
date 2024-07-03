class Housing {
  final String housingId;
  final String housingName;

  const Housing({
    required this.housingId,
    required this.housingName,
  });

  factory Housing.fromJson(Map<String, dynamic> data) {
    return Housing(
      housingId: data['id_perumahan'],
      housingName: data['nama_perumahan'],
    );
  }
}
