import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_theme.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item_model.dart';

class TicketDetailScreen extends StatelessWidget {
  final Map<String, String> ticket;

  const TicketDetailScreen({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ticket['title'] ?? 'Ticket')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 220,
              width: double.infinity,
              child: Image.network(
                ticket['image'] ?? '',
                fit: BoxFit.cover,
                errorBuilder: (c, e, st) => Container(color: AppTheme.lightGrey, child: const Center(child: Icon(Icons.photo, size: 48, color: AppTheme.grey))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ticket['title'] ?? '', style: const TextStyle(fontSize: AppTheme.fontSizeTitle, fontWeight: FontWeight.bold)),
                  const SizedBox(height: AppTheme.spacingSmall),
                  Text(ticket['subtitle'] ?? '', style: const TextStyle(color: AppTheme.textSecondary)),
                  const SizedBox(height: AppTheme.spacingLarge),
                  Text(ticket['price'] ?? '', style: const TextStyle(fontSize: AppTheme.fontSizeLarge, fontWeight: FontWeight.bold, color: AppTheme.primaryRed)),
                  const SizedBox(height: AppTheme.spacingLarge),
                  ElevatedButton(
                    onPressed: () async {
                      // Create a mock CartItemModel and add to provider
                      final cartProvider = Provider.of<CartProvider>(context, listen: false);
                      final item = CartItemModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        type: 'ticket',
                        itemId: ticket['title'] ?? 'ticket',
                        title: ticket['title'] ?? 'Ticket',
                        subtitle: ticket['subtitle'],
                        quantity: 1,
                        price: double.tryParse((ticket['price'] ?? '0').replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0,
                        imageUrl: ticket['image'],
                      );

                      await cartProvider.addItem(item);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added ${item.title} to cart')));
                      Navigator.of(context).pop();
                    },
                    child: const Text('เพิ่มลงตะกร้า / จอง'),
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
