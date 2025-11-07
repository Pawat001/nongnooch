import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';
import '../utils/app_theme.dart';
import '../localization/app_localizations.dart';
import 'login_screen.dart';

/// Cart Screen - หน้าตะกร้าสินค้า with Auth Flow
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization?.cart ?? 'ตะกร้า'),
      ),
      body: cartProvider.isEmpty
          ? _buildEmptyCart(context, localization)
          : _buildCartContent(context, localization, cartProvider),
      bottomNavigationBar: cartProvider.isNotEmpty
          ? _buildCheckoutButton(context, localization, cartProvider)
          : null,
    );
  }

  Widget _buildEmptyCart(BuildContext context, AppLocalizations? localization) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty cart placeholder image from the web.
            // TODO: Replace with a local asset at assets/images/cart_empty.jpg for offline use
            SizedBox(
              width: 140,
              height: 140,
              child: Image.network(
                'https://source.unsplash.com/featured/?shopping,cart',
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppTheme.lightGrey,
                    child: const Center(
                      child: Icon(Icons.shopping_cart_outlined, color: AppTheme.grey, size: 48),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppTheme.spacingLarge),
            Text(
              localization?.cartEmpty ?? 'ตะกร้าว่างเปล่า',
              style: const TextStyle(
                fontSize: AppTheme.fontSizeTitle,
                fontWeight: FontWeight.bold,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: AppTheme.spacingMedium),
            const Text(
              'เริ่มเลือกบริการที่คุณต้องการ',
              style: TextStyle(
                fontSize: AppTheme.fontSizeMedium,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartContent(
    BuildContext context,
    AppLocalizations? localization,
    CartProvider cartProvider,
  ) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              itemCount: cartProvider.items.length,
              itemBuilder: (context, index) {
                final item = cartProvider.items[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
                  child: ListTile(
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppTheme.lightGrey,
                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                      ),
                      // Item image placeholder.
                      // TODO: If CartItem provides image url, use it; otherwise replace with local asset in assets/images/
                      child: Image.network(
                        'https://source.unsplash.com/featured/?ticket,attraction',
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 1.5),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.image, color: AppTheme.grey),
                          );
                        },
                      ),
                    ),
                    title: Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (item.subtitle != null)
                          Text(item.subtitle!),
                        Text(
                          '฿${item.price.toStringAsFixed(0)} x ${item.quantity}',
                          style: const TextStyle(color: AppTheme.primaryRed),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: AppTheme.error),
                      onPressed: () {
                        cartProvider.removeItem(item.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          _buildPriceSummary(localization, cartProvider),
        ],
      ),
    );
  }

  Widget _buildPriceSummary(AppLocalizations? localization, CartProvider cartProvider) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      decoration: BoxDecoration(
        color: AppTheme.white,
        boxShadow: [
          BoxShadow(
            color: AppTheme.grey.withAlpha(77),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localization?.totalPrice ?? 'ราคารวม',
                style: const TextStyle(fontSize: AppTheme.fontSizeMedium),
              ),
              Text(
                '฿${cartProvider.subtotal.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: AppTheme.fontSizeMedium),
              ),
            ],
          ),
          if (cartProvider.totalDiscount > 0) ...[
            const SizedBox(height: AppTheme.spacingSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localization?.discount ?? 'ส่วนลด',
                  style: const TextStyle(
                    fontSize: AppTheme.fontSizeMedium,
                    color: AppTheme.error,
                  ),
                ),
                Text(
                  '-฿${cartProvider.totalDiscount.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: AppTheme.fontSizeMedium,
                    color: AppTheme.error,
                  ),
                ),
              ],
            ),
          ],
          const Divider(height: AppTheme.spacingLarge),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localization?.grandTotal ?? 'ยอดรวมสุทธิ',
                style: const TextStyle(
                  fontSize: AppTheme.fontSizeLarge,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '฿${cartProvider.grandTotal.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: AppTheme.fontSizeLarge,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryRed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(
    BuildContext context,
    AppLocalizations? localization,
    CartProvider cartProvider,
  ) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        child: ElevatedButton(
          onPressed: () {
            final authProvider = context.read<AuthProvider>();
            // Auth Flow: Check login before checkout
            if (!authProvider.isLoggedIn) {
              // Show login required dialog
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('จำเป็นต้องเข้าสู่ระบบ'),
                  content: const Text('กรุณาเข้าสู่ระบบเพื่อดำเนินการชำระเงิน'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('ยกเลิก'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                        );
                      },
                      child: const Text('เข้าสู่ระบบ'),
                    ),
                  ],
                ),
              );
              return;
            }
            // Proceed to checkout (mock)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${localization?.proceedToCheckout ?? "ดำเนินการชำระเงิน"}\n'
                  'ยอดรวม ฿${cartProvider.grandTotal.toStringAsFixed(0)} (ผู้ใช้: ${authProvider.userName})',
                ),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 3),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
          ),
          child: Text(
            localization?.proceedToCheckout ?? 'ดำเนินการชำระเงิน',
            style: const TextStyle(
              fontSize: AppTheme.fontSizeNormal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
