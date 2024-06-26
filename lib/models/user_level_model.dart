class UserLevelModel {
  final String userLevelId;
  final String userLevelName;

  const UserLevelModel({
    required this.userLevelId,
    required this.userLevelName,
  });

  factory UserLevelModel.fromJson(Map<String, dynamic> data) {
    return UserLevelModel(
      userLevelId: data['id_user_lvl'],
      userLevelName: data['nama_user_lvl'],
    );
  }
}
