import 'dart:convert';
import 'dart:typed_data';

class InformationModel {
  final String id;
  final String title;
  final String body;
  final String postDate;
  final int postBy;
  final String postinger;
  final Uint8List image;
  final String isActive;

  const InformationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.postDate,
    required this.postBy,
    required this.postinger,
    required this.image,
    required this.isActive,
  });

  factory InformationModel.fromJson(Map<String, dynamic> data) {
    return InformationModel(
      id: data['id_informasi'],
      title: data['judul_informasi'],
      body: data['isi_informasi'],
      postDate: data['posting_at'],
      postBy: data['posting_by'],
      postinger: data['name'],
      image: base64Decode(data['gambar']),
      isActive: data['is_aktif'],
    );
  }
}
