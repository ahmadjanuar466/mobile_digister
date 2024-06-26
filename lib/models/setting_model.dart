import 'package:flutter/material.dart';

class SettingItem {
  const SettingItem(this.icon, this.title);

  final Icon icon;
  final String title;
}

List<SettingItem> settingItems = [
  SettingItem(
    Icon(
      Icons.support_agent_outlined,
      size: 28,
    ),
    "Pusat bantuan",
  ),
];
