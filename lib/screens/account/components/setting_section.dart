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
          horizontalTitleGap: 8.0,
          leading: const Icon(Icons.color_lens_rounded),
          title: Text(isDarkMode ? 'Mode gelap' : 'Mode terang'),
          trailing: Switch(
            value: isDarkMode,
            onChanged: onChanged,
          ),
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
        // const ListTile(
        //   contentPadding: EdgeInsets.zero,
        //   horizontalTitleGap: 8.0,
        //   leading: Icon(Icons.article_rounded),
        //   title: Text('Ketentuan layanan'),
        //   trailing: Icon(Icons.arrow_forward_ios_rounded),
        // ),
        // const ListTile(
        //   contentPadding: EdgeInsets.zero,
        //   horizontalTitleGap: 8.0,
        //   leading: Icon(Icons.privacy_tip_rounded),
        //   title: Text('Kebijakan privasi'),
        //   trailing: Icon(Icons.arrow_forward_ios_rounded),
        // ),
      ],
    );
  }
}
