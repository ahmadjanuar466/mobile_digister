import 'package:digister/models/dues_model.dart';

class ConfirmDuesModel {
  final int total;
  final List<DuesModel> dues;

  const ConfirmDuesModel({
    required this.total,
    required this.dues,
  });
}
