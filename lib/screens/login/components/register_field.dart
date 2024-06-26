import 'package:digister/models/block_model.dart';
import 'package:digister/models/housing_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/main/main_screen.dart';
import 'package:digister/services/auth.dart';
import 'package:digister/services/housing.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/widgets/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:localstorage/localstorage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toastification/toastification.dart';

class RegisterField extends StatefulWidget {
  const RegisterField({super.key});

  @override
  State<RegisterField> createState() => _RegisterFieldState();
}

class _RegisterFieldState extends State<RegisterField> {
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _houseNumController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final List<BlockModel> _blocks = [];
  final List<HousingModel> _housings = [];
  bool _isPasswordVisible = false;
  String? _currentBlock;
  String? _currentHousing;

  @override
  void initState() {
    super.initState();
    _getBlocks();
    _getHousings();
  }

  void _getBlocks() async {
    final blocks = await getBlocks();

    setState(() {
      _blocks.addAll(blocks);
    });
  }

  void _getHousings() async {
    final housings = await getHousings();

    setState(() {
      _housings.addAll(housings);
    });
  }

  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      final body = {
        "nik": _nikController.text,
        "nama": _namaController.text,
        "id_perumahan": _currentHousing,
        "blok": _currentBlock,
        "no_telp": _phoneController.text,
        "no_rumah": _houseNumController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
      };

      final isRegister = await doRegister(body);

      if (!isRegister) {
        return;
      }

      final isLogin = await doLogin(body);

      if (isLogin) {
        localStorage.setItem('isFirst', '0');
        RouteHelper.pushAndRemoveUntil(
          // ignore: use_build_context_synchronously
          context,
          widget: const MainScreen(),
          transitionType: PageTransitionType.rightToLeft,
        );
        return;
      }

      NotificationWidget.show(
        title: 'Success!',
        description: 'Registrasi berhasil. Silahkan untuk login',
        type: ToastificationType.success,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ...[
            TextFormField(
              controller: _nikController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'NIK',
              ),
              validator: validator,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _namaController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Nama',
              ),
              validator: validator,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'No. Hp',
              ),
              validator: validator,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              menuMaxHeight: 200,
              dropdownColor: isDarkMode
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.onPrimary,
              items: _housings
                  .map(
                    (item) => DropdownMenuItem(
                      value: item.housingId,
                      child: Text(item.housingName),
                    ),
                  )
                  .toList(),
              decoration: const InputDecoration(
                labelText: 'Perumahan',
              ),
              onChanged: (value) {
                setState(() {
                  _currentHousing = value;
                });
              },
              validator: validator,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              menuMaxHeight: 200,
              dropdownColor: isDarkMode
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.onPrimary,
              items: _blocks
                  .map(
                    (item) => DropdownMenuItem(
                      value: item.blockName,
                      child: Text(item.blockName),
                    ),
                  )
                  .toList(),
              decoration: const InputDecoration(
                labelText: 'Blok',
              ),
              onChanged: (value) {
                setState(() {
                  _currentBlock = value;
                });
              },
              validator: validator,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _houseNumController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'No. Rumah',
              ),
              validator: validator,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: validator,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    !_isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
              validator: validator,
            ),
          ]
              .animate(interval: 100.ms)
              .fadeIn(duration: 200.ms, delay: 100.ms)
              .move(
                begin: const Offset(-16, 0),
                curve: Curves.easeOutQuad,
              ),
          const SizedBox(height: 20),
          SizedBox(
            height: 45,
            child: ElevatedButton(
              onPressed: _handleRegister,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.app_registration),
                  SizedBox(width: 4.0),
                  Text('Registrasi'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
