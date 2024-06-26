class DuesModel {
  final int? userId;
  final String nik;
  final String name;
  final String block;
  final int houseNum;
  final String? paymentDate;
  final int? paymentMonth;
  final String? paymentYear;
  final String? duesType;
  final String? duesId;
  final int? duesPrice;
  final int? isValid;
  final String? proofOfPayment;
  final String? explanation;

  const DuesModel({
    required this.userId,
    required this.nik,
    required this.name,
    required this.block,
    required this.houseNum,
    this.duesPrice,
    this.duesType,
    this.duesId,
    this.paymentDate,
    this.paymentMonth,
    this.paymentYear,
    this.isValid,
    this.proofOfPayment,
    this.explanation,
  });

  factory DuesModel.fromJson(Map<String, dynamic> data) {
    return DuesModel(
      userId: int.tryParse(data['id'] ?? "") ?? data['id'],
      nik: data['nik'],
      name: data['nama'],
      block: data['blok'],
      houseNum: data['no_rumah'],
      duesPrice: data['harga'],
      duesType: data['nama_jenis_iuran'],
      paymentDate: data['tgl_pembayaran'],
      paymentMonth: data['pembayaran_bln'],
      paymentYear: data['pembayaran_thn'],
      isValid: data['is_valid'],
      proofOfPayment: data['bukti_pembayaran'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "nik": nik,
      "id_jenis_iuran": duesId!,
      "tgl_pembayaran": paymentDate!,
      "bukti_pembayaran": proofOfPayment!,
      "pembayaran_bln": paymentMonth!,
      "pembayaran_thn": paymentYear!,
      "keterangan": explanation ?? "",
    };
  }

  Map<String, dynamic> toMapValidate() {
    return {
      "nik": nik,
      "tgl_pembayaran": paymentDate!,
      "pembayaran_bln": paymentMonth!,
      "pembayaran_thn": paymentYear!,
    };
  }
}
