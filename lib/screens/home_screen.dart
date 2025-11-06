import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../localization/app_localizations.dart';

/// Home Screen - หน้าหลักสไตล์ Agoda
/// มี Search Bar, Category Chips, Deal Cards (horizontal scroll), และ Recommended Grid
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Search Section (Agoda-style)
            _buildHeroSearch(context, localization),
            
            const SizedBox(height: AppTheme.spacingMedium),
            
            // Category Chips (horizontal scroll)
            _buildCategoryChips(),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // Hot Deals Section (horizontal cards)
            _buildSectionTitle(localization?.yourPromotions ?? 'ดีลสุดคุ้ม'),
            const SizedBox(height: AppTheme.spacingMedium),
            _buildHotDeals(),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // Recommended for You (grid)
            _buildSectionTitle(localization?.recommendedAttractions ?? 'แนะนำสำหรับคุณ'),
            const SizedBox(height: AppTheme.spacingMedium),
            _buildRecommendedGrid(),
            
            const SizedBox(height: AppTheme.spacingXLarge),
          ],
        ),
      ),
    );
  }

  /// Hero Search Section (Agoda-style prominent search bar)
  Widget _buildHeroSearch(BuildContext context, AppLocalizations? localization) {
    return Container(
      margin: const EdgeInsets.all(AppTheme.spacingMedium),
      padding: const EdgeInsets.all(AppTheme.spacingLarge),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryRed, AppTheme.primaryRed.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryRed.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localization?.appName ?? 'สวนนงนุช',
            style: const TextStyle(
              color: AppTheme.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'จองตั๋ว ที่พัก ร้านอาหาร ได้ในที่เดียว',
            style: TextStyle(color: AppTheme.white, fontSize: 14),
          ),
          const SizedBox(height: AppTheme.spacingLarge),
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ค้นหาตั๋ว ที่พัก ร้านอาหาร...',
                prefixIcon: const Icon(Icons.search, color: AppTheme.primaryRed),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              onTap: () {
                // TODO: Navigate to search screen
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Category Chips (horizontal scroll)
  Widget _buildCategoryChips() {
    final categories = [
      {'label': 'ทั้งหมด', 'icon': Icons.apps},
      {'label': 'ตั๋วเข้าชม', 'icon': Icons.confirmation_number},
      {'label': 'ที่พัก', 'icon': Icons.hotel},
      {'label': 'ร้านอาหาร', 'icon': Icons.restaurant},
      {'label': 'โปรโมชั่น', 'icon': Icons.local_offer},
    ];

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final selected = _selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategoryIndex = index),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: selected ? AppTheme.primaryRed : AppTheme.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: selected ? AppTheme.primaryRed : AppTheme.lightGrey),
                boxShadow: selected
                    ? [BoxShadow(color: AppTheme.primaryRed.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2))]
                    : [],
              ),
              child: Row(
                children: [
                  Icon(cat['icon'] as IconData, size: 18, color: selected ? AppTheme.white : AppTheme.textSecondary),
                  const SizedBox(width: 8),
                  Text(
                    cat['label'] as String,
                    style: TextStyle(
                      color: selected ? AppTheme.white : AppTheme.textPrimary,
                      fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Hot Deals (horizontal card list)
  /// TODO: ข้อมูลจาก https://www.nongnoochpattaya.com/th/ - โปรโมชั่นและแพ็คเกจพิเศษ
  Widget _buildHotDeals() {
    final deals = [
      {
        'title': 'แพ็คเกจสวนนงนุชพัทยา',
        'subtitle': 'ตั๋ว + รถราง + บุฟเฟ่ต์ ครบจบในที่เดียว',
        'price': '฿1,299',
  'image': 'assets/images/S__3907804.jpg',
        'discount': '20%',
      },
      {
        'title': 'การ์เด้น วิลล่า Deluxe',
        'subtitle': 'พักผ่อน 2 ห้องนอน วิวสวนสวย',
        'price': '฿3,800',
  'image': 'assets/images/S__3907804.jpg',
        'discount': '15%',
      },
      {
        'title': 'โปรโมชั่น มา 3 จ่าย 2',
        'subtitle': 'คุ้มสุด! พาเพื่อนมา 3 คน จ่ายเพียง 2 คน',
        'price': '฿1,200',
  'image': 'assets/images/S__3907804.jpg',
        'discount': '33%',
      },
      {
        'title': 'บุฟเฟ่ต์นานาชาติ',
        'subtitle': 'อิ่มไม่อั้น เมนูไทยและสากล',
        'price': '฿850',
  'image': 'assets/images/S__3907804.jpg',
        'discount': '10%',
      },
    ];

    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium),
        itemCount: deals.length,
        itemBuilder: (context, index) {
          final deal = deals[index];
          return Container(
            width: 280,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
              boxShadow: [
                BoxShadow(color: AppTheme.grey.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(AppTheme.borderRadiusLarge)),
                      child: _buildResponsiveImage(deal['image']!, height: 140),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryRed,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(deal['discount']!, style: const TextStyle(color: AppTheme.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(deal['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(deal['subtitle']!, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(deal['price']!, style: const TextStyle(color: AppTheme.primaryRed, fontWeight: FontWeight.bold, fontSize: 18)),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(minimumSize: const Size(80, 36), padding: const EdgeInsets.symmetric(horizontal: 12)),
                            child: const Text('จอง', style: TextStyle(fontSize: 13)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Recommended Grid (2 columns)
  /// TODO: ข้อมูลจาก https://www.nongnoochpattaya.com/th/ - สถานที่ท่องเที่ยวภายใน
  Widget _buildRecommendedGrid() {
    final items = [
      {
        'title': 'บัตรเข้าชมสวนนงนุช',
        'subtitle': 'เข้าชมทั้งวัน ชมสวนสวย',
        'price': '฿600',
        'image': 'assets/images/S__3907804.jpg'
      },
      {
        'title': 'หุบเขาไดโนเสาร์',
        'subtitle': 'จุดเช็คอินยอดนิยม',
        'price': '฿600',
        'image': 'https://www.nongnoochpattaya.com/uploads/images/202011/783dc305a7cca40fd0923e609d520b7e.jpg'
      },
      {
        'title': 'สวนพฤกษศาสตร์',
        'subtitle': 'ชมพรรณไม้นานาชนิด',
        'price': '฿600',
        'image': 'https://www.nongnoochpattaya.com/r/400/auto/uploads/images/202009/a13a69a4fbdc44cfce73352184ca7842.jpg'
      },
      {
        'title': 'สวนดอกไม้พญานาค',
        'subtitle': 'สวนดอกไม้สุดอลังการ',
        'price': '฿600',
        'image': 'https://www.nongnoochpattaya.com/r/400/auto/uploads/images/202009/c7aded86816b5c4d4f3a8cbb75b08e1b.jpg'
      },
      {
        'title': 'นงนุชรีสอร์ต',
        'subtitle': 'พักผ่อน วิวสระว่ายน้ำ',
        'price': '฿2,200',
        'image': 'https://www.nongnoochpattaya.com/uploads/images/202011/783dc305a7cca40fd0923e609d520b7e.jpg'
      },
      {
        'title': 'การ์เด้น วิลล่า',
        'subtitle': '2 ห้องนอน ครอบครัว',
        'price': '฿3,800',
        'image': 'https://www.nongnooch.world/nongnooch-home-img/assets/resort_master_image/preview/garden_1.png'
      },
      {
        'title': 'บุฟเฟ่ต์นานาชาติ',
        'subtitle': 'อิ่มไม่อั้น เมนูหลากหลาย',
        'price': '฿850',
        'image': 'https://www.nongnoochpattaya.com/uploads/images/202305/051eb287229bb8522079c34ee2b8cddc.jpg'
      },
      {
        'title': 'กวนเกษียรสมุทร',
        'subtitle': 'ประติมากรรมตัวแทนพระพุทธศาสนา',
        'price': '฿600',
        'image': 'https://www.nongnoochpattaya.com/r/400/auto/uploads/images/202401/775c4b6d6fabf8fc6388d38c2d8bf0e3.jpg'
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
              boxShadow: [BoxShadow(color: AppTheme.grey.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(AppTheme.borderRadiusLarge)),
                  child: _buildResponsiveImage(item['image']!, height: 120),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Text(item['subtitle']!, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 8),
                      Text(item['price']!, style: const TextStyle(color: AppTheme.primaryRed, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Utility to support both network and local asset images
  Widget _buildResponsiveImage(String src, {double? height}) {
    final isNetwork = src.startsWith('http');
    if (isNetwork) {
      return Image.network(
        src,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (c, child, progress) {
          if (progress == null) return child;
          return Container(height: height ?? 120, color: AppTheme.lightGrey, child: const Center(child: CircularProgressIndicator()));
        },
        errorBuilder: (c, e, st) => Container(height: height ?? 120, color: AppTheme.lightGrey, child: const Icon(Icons.photo, size: 40)),
      );
    }

    // Local asset
    return Image.asset(
      src,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (c, e, st) => Container(height: height ?? 120, color: AppTheme.lightGrey, child: const Icon(Icons.photo, size: 40)),
    );
  }

  /// Section Title Helper
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppTheme.textPrimary,
        ),
      ),
    );
  }
}
