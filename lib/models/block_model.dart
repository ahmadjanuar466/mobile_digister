class Block {
  final String blockId;
  final String blockName;

  const Block({
    required this.blockId,
    required this.blockName,
  });

  factory Block.fromJson(Map<String, dynamic> data) {
    return Block(
      blockId: data['id_blok'],
      blockName: data['nama_blok'],
    );
  }
}
