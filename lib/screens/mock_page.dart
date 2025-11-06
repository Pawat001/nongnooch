import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

/// Generic mock page used for menu items in Profile
class MockPage extends StatelessWidget {
  final String title;
  final String subtitle;

  const MockPage({super.key, required this.title, this.subtitle = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: AppTheme.fontSizeTitle, fontWeight: FontWeight.bold)),
              const SizedBox(height: AppTheme.spacingSmall),
              Text(subtitle, style: const TextStyle(color: AppTheme.textSecondary)),
              const SizedBox(height: AppTheme.spacingLarge),
              const Text('This is a mockup page for the feature. Implement functionality here.'),
            ],
          ),
        ),
      ),
    );
  }
}
