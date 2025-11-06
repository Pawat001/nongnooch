import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../providers/cart_provider.dart';
import '../localization/app_localizations.dart';
import '../api/swagger_spec_fetcher.dart';
import '../utils/app_theme.dart';
import 'home_screen.dart';
import 'tickets_screen.dart';
import 'rooms_screen.dart';
import 'restaurants_screen.dart';
import 'profile_screen.dart';
import 'cart_screen.dart';

/// Main Navigation Screen พร้อม Bottom Navigation Bar 5 เมนู
/// Home | Tickets | Rooms | F&B | Profile
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // List of screens for each tab
  final List<Widget> _screens = const [
    HomeScreen(),
    TicketsScreen(),
    RoomsScreen(),
    RestaurantsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localization?.appName ?? 'สวนนงนุช',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          // Language Toggle Button
          IconButton(
            icon: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingSmall,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: AppTheme.white.withAlpha(51),
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
              ),
              child: Text(
                languageProvider.isThaiLanguage ? 'TH' : 'EN',
                style: const TextStyle(
                  color: AppTheme.white,
                  fontWeight: FontWeight.bold,
                  fontSize: AppTheme.fontSizeMedium,
                ),
              ),
            ),
            onPressed: () async {
              await languageProvider.toggleLanguage();
            },
            tooltip: 'Switch Language',
          ),

          // Cart Icon with Badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
                tooltip: localization?.cart ?? 'Cart',
              ),
              if (cartProvider.itemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGold,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.white, width: 1.5),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      cartProvider.itemCount > 9
                        ? '9+'
                        : cartProvider.itemCount.toString(),
                      style: const TextStyle(
                        color: AppTheme.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppTheme.spacingSmall),
          // Debug: fetch OpenAPI/Swagger spec and show top-level keys
          IconButton(
            icon: const Icon(Icons.cloud_download_outlined),
            tooltip: 'Fetch API Spec',
            onPressed: () async {
              final fetcher = SwaggerSpecFetcher();
              const specUrl = 'https://sales-backend.nongnooch.app/v3/api-docs';
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (ctx) => const Center(child: CircularProgressIndicator()),
              );
              try {
                final spec = await fetcher.fetchSpec(specUrl);
                Navigator.of(context).pop(); // close progress
                final keys = spec.keys.map((k) => k.toString()).toList();
                final preview = keys.take(20).join(', ');
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Spec fetched'),
                    content: SingleChildScrollView(child: Text('Top keys (${keys.length}):\n$preview')),
                    actions: [
                      TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('OK')),
                    ],
                  ),
                );
              } catch (e) {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Fetch failed'),
                    content: Text(e.toString()),
                    actions: [TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Close'))],
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primaryRed,
        unselectedItemColor: AppTheme.grey,
        selectedLabelStyle: const TextStyle(
          fontSize: AppTheme.fontSizeSmall,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: AppTheme.fontSizeSmall,
        ),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: localization?.home ?? 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.confirmation_number_outlined),
            activeIcon: const Icon(Icons.confirmation_number),
            label: localization?.tickets ?? 'จองตั๋ว',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.hotel_outlined),
            activeIcon: const Icon(Icons.hotel),
            label: localization?.rooms ?? 'จองที่พัก',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.restaurant_outlined),
            activeIcon: const Icon(Icons.restaurant),
            label: localization?.restaurants ?? 'ร้านอาหาร',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: localization?.profile ?? 'โปรไฟล์',
          ),
        ],
      ),
    );
  }
}
