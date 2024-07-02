import 'package:digister/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/widgets/custom_button.dart';

class NIKField extends StatefulWidget {
  const NIKField({super.key});

  @override
  State<NIKField> createState() => _NIKFieldState();
}

class _NIKFieldState extends State<NIKField> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nikController = TextEditingController();

  @override
  void dispose() {
    _nikController.dispose();
    super.dispose();
  }

  _handleCheckNIK() async {
    if (_formKey.currentState!.validate()) {
      showLoader(context, "Memeriksa NIK");

      final nikExist = await checkUserNIK({'nik': _nikController.text});

      // ignore: use_build_context_synchronously
      Navigator.pop(context);

      if (nikExist) {
        forgotPasswordModel.addNik(_nikController.text);
        forgotPasswordModel.changeState({
          "title": "Buat Sandi Baru",
          "description":
              "Silahkan buat kata sandi baru. Kata sandi tidak boleh sama dengan kata sandi yang lama.",
          "isChangingPassword": true,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nikController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Nik'),
            validator: validator,
          ),
          const Spacer(),
          CustomButton(
            text: "Kirim",
            onPressed: _handleCheckNIK,
          ),
        ],
      ),
    );
  }
}
