import 'package:flutter/material.dart';
import 'mock_page.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MockPage(title: 'ตั้งค่า', subtitle: 'จัดการการตั้งค่าบัญชีและการแจ้งเตือน');
  }
}
