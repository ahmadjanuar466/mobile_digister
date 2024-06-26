class BlockModel {
  final String blockId;
  final String blockName;

  const BlockModel({
    required this.blockId,
    required this.blockName,
  });

  factory BlockModel.fromJson(Map<String, dynamic> data) {
    return BlockModel(
      blockId: data['id_blok'],
      blockName: data['nama_blok'],
    );
  }
}
