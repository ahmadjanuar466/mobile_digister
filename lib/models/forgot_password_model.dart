import 'package:flutter/material.dart';

class ForgotPassword extends ChangeNotifier {
  Map<String, dynamic> _screenState = {
    "title": "Lupa Sandi",
    "description":
        "Silahkan masukkan NIK yang anda gunakan di akun anda. Sistem kami akan mengecek NIK anda agar dapat melakukan perubahan kata sandi.",
    "isChangingPassword": false,
  };
  String _nik = '';

  Map<String, dynamic> get screenState => _screenState;
  String get nik => _nik;

  void changeState(Map<String, dynamic> newState) {
    _screenState = newState;
    notifyListeners();
  }

  void addNik(String nik) {
    _nik = nik;
    notifyListeners();
  }
}
