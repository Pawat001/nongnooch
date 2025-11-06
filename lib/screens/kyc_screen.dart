import 'package:flutter/material.dart';
import 'mock_page.dart';

class KycScreen extends StatelessWidget {
  const KycScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MockPage(title: 'ยืนยันตัวตน (KYC)', subtitle: 'ยืนยันตัวตนเพื่อรับสิทธิพิเศษ');
  }
}
