import 'package:flutter/material.dart';
import 'mock_page.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MockPage(title: 'การจองของฉัน', subtitle: 'ดูประวัติการจองและสถานะ');
  }
}
