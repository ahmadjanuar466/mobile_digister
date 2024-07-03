class UserLevel {
  final String userLevelId;
  final String userLevelName;

  const UserLevel({
    required this.userLevelId,
    required this.userLevelName,
  });

  factory UserLevel.fromJson(Map<String, dynamic> data) {
    return UserLevel(
      userLevelId: data['id_user_lvl'],
      userLevelName: data['nama_user_lvl'],
    );
  }
}
