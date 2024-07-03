import 'package:digister/models/dues_model.dart';

class ConfirmDues {
  final int total;
  final List<Dues> dues;

  const ConfirmDues({
    required this.total,
    required this.dues,
  });
}
