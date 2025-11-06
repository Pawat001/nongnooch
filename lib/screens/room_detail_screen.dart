import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_theme.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item_model.dart';

class RoomDetailScreen extends StatelessWidget {
  final Map<String, dynamic> room;

  const RoomDetailScreen({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    final features = (room['features'] as List<dynamic>?)?.cast<String>() ?? <String>[];
    return Scaffold(
      appBar: AppBar(title: Text(room['title'] ?? 'Room')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 240,
              width: double.infinity,
              child: Image.network(
                room['image'] ?? '',
                fit: BoxFit.cover,
                errorBuilder: (c, e, st) => Container(color: AppTheme.lightGrey, child: const Center(child: Icon(Icons.bed, size: 48, color: AppTheme.grey))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(room['title'] ?? '', style: const TextStyle(fontSize: AppTheme.fontSizeTitle, fontWeight: FontWeight.bold)),
                  const SizedBox(height: AppTheme.spacingSmall),
                  Text(room['subtitle'] ?? '', style: const TextStyle(color: AppTheme.textSecondary)),
                  const SizedBox(height: AppTheme.spacingSmall),
                  Wrap(spacing: 8, children: features.map((f) => Chip(label: Text(f), backgroundColor: AppTheme.primaryRed.withAlpha(20))).toList()),
                  const SizedBox(height: AppTheme.spacingLarge),
                  Text(room['price'] ?? '', style: const TextStyle(fontSize: AppTheme.fontSizeLarge, fontWeight: FontWeight.bold, color: AppTheme.primaryRed)),
                  const SizedBox(height: AppTheme.spacingLarge),
                  ElevatedButton(
                    onPressed: () async {
                      final cartProvider = Provider.of<CartProvider>(context, listen: false);
                      final item = CartItemModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        type: 'room',
                        itemId: room['title'] ?? 'room',
                        title: room['title'] ?? 'Room',
                        subtitle: room['subtitle'],
                        quantity: 1,
                        price: double.tryParse((room['price'] ?? '0').replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0,
                        imageUrl: room['image'],
                        metadata: {'features': room['features']},
                      );

                      await cartProvider.addItem(item);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added ${item.title} to cart')));
                      Navigator.of(context).pop();
                    },
                    child: const Text('จองห้อง'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
