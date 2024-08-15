import 'package:digister/utils/size_util.dart';
import 'package:flutter/material.dart';

class SettingSection extends StatelessWidget {
  const SettingSection({
    super.key,
    required this.isDarkMode,
    required this.onChanged,
  });

  final bool isDarkMode;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 8.0.h,
          leading: const Icon(Icons.color_lens_rounded),
          title: Text(isDarkMode ? 'Mode gelap' : 'Mode terang'),
          trailing: Switch(
            value: isDarkMode,
            onChanged: onChanged,
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 8.0.h,
          leading: const Icon(Icons.article_rounded),
          title: const Text('Ketentuan layanan'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 8.0.h,
          leading: const Icon(Icons.privacy_tip_rounded),
          title: const Text('Kebijakan privasi'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 8.0.h,
          leading: const Icon(Icons.no_accounts_rounded),
          title: const Text('Ajukan hapus akun'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
        // const ListTile(
        //   contentPadding: EdgeInsets.zero,
        //   horizontalTitleGap: 8.0,
        //   leading: Icon(Icons.support_agent_rounded),
        //   title: Text('Pusat bantuan'),
        //   trailing: Icon(Icons.arrow_forward_ios_rounded),
        // ),
        // const ListTile(
        //   contentPadding: EdgeInsets.zero,
        //   horizontalTitleGap: 8.0,
        //   leading: Icon(Icons.lock_rounded),
        //   title: Text('Ubah kode PIN'),
        //   trailing: Icon(Icons.arrow_forward_ios_rounded),
        // ),
      ],
    );
  }
}
