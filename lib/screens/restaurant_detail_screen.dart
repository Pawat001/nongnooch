import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_theme.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item_model.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Map<String, String> restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(restaurant['name'] ?? 'Restaurant')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 220,
              width: double.infinity,
              child: Image.network(
                restaurant['image'] ?? '',
                fit: BoxFit.cover,
                errorBuilder: (c, e, st) => Container(color: AppTheme.lightGrey, child: const Center(child: Icon(Icons.photo, size: 48, color: AppTheme.grey))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restaurant['name'] ?? '', style: const TextStyle(fontSize: AppTheme.fontSizeTitle, fontWeight: FontWeight.bold)),
                  const SizedBox(height: AppTheme.spacingSmall),
                  Text('${restaurant['cuisine'] ?? ''} • ${restaurant['hours'] ?? ''}', style: const TextStyle(color: AppTheme.textSecondary)),
                  const SizedBox(height: AppTheme.spacingLarge),
                  ElevatedButton(
                    onPressed: () async {
                      // For restaurants, we add as 'food' item or 'restaurant_reservation'
                      final cartProvider = Provider.of<CartProvider>(context, listen: false);
                      final item = CartItemModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        type: 'restaurant',
                        itemId: restaurant['name'] ?? 'restaurant',
                        title: restaurant['name'] ?? 'Restaurant',
                        subtitle: restaurant['cuisine'],
                        quantity: 1,
                        price: 0.0,
                        imageUrl: restaurant['image'],
                        metadata: {'hours': restaurant['hours']},
                      );

                      await cartProvider.addItem(item);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reserved ${item.title} (mock) added to cart')));
                      Navigator.of(context).pop();
                    },
                    child: const Text('สำรองโต๊ะ'),
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
