import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_theme.dart';
import '../localization/app_localizations.dart';
import 'restaurant_detail_screen.dart';
import '../providers/quotation_types_provider.dart';
import '../services/nongnooch_api_service.dart';

/// Restaurants Screen - หน้าร้านอาหารและเมนู
class RestaurantsScreen extends StatefulWidget {
  const RestaurantsScreen({super.key});

  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<QuotationTypesProvider>().ensureLoaded();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => context.read<QuotationTypesProvider>().fetchTypes(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppTheme.spacingMedium),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 110,
                  height: 110,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://source.unsplash.com/featured/?restaurant,food',
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)));
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(color: AppTheme.lightGrey, child: const Center(child: Icon(Icons.restaurant, color: AppTheme.grey)));
                      },
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingMedium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(localization?.restaurantBooking ?? 'ร้านอาหารและเมนูอาหาร', style: const TextStyle(fontSize: AppTheme.fontSizeTitle, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      const Text('ดูเมนูรูปภาพและสำรองโต๊ะล่วงหน้า', style: TextStyle(color: AppTheme.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingLarge),

            // Dining types from API
            _buildSectionTitle('หมวดหมู่ร้านอาหาร/จัดเลี้ยง (API)'),
            const SizedBox(height: AppTheme.spacingSmall),
            _buildTypesChips(context),
            const SizedBox(height: AppTheme.spacingLarge),

            _buildSectionTitle(localization?.yourPromotions ?? 'ร้านแนะนำ'),
            const SizedBox(height: AppTheme.spacingSmall),
            _buildRestaurantList(context),
            ],
          ),
          ),
      ),
    );
  }

  // TODO: ข้อมูลจริงจาก https://www.nongnoochpattaya.com/th/ - ควรเพิ่มหน้าร้านอาหาร
  // ข้อมูลเหล่านี้เป็นตัวอย่าง เนื่องจากเว็บไม่มีหน้าแยกสำหรับร้านอาหาร
  List<Map<String, String>> get _sampleRestaurants => [
        {
          'name': 'ร้านอาหารสวนนงนุช',
          'cuisine': 'อาหารไทย / นานาชาติ',
          'hours': '08:00 - 20:00 น.',
          'image': 'https://www.nongnoochpattaya.com/r/400/auto/uploads/images/202401/775c4b6d6fabf8fc6388d38c2d8bf0e3.jpg',
          'tags': 'restaurant,thai',
        },
        {
          'name': 'ลิโด ภัตตาคาร',
          'cuisine': 'บุฟเฟ่ต์ไทย-สากล',
          'hours': '11:30 - 14:30, 18:00 - 21:00 น.',
          'image': 'https://www.nongnoochpattaya.com/uploads/images/202305/051eb287229bb8522079c34ee2b8cddc.jpg',
          'tags': 'restaurant,buffet,banquet',
        },
        {
          'name': 'ร้านกาแฟ Garden Café',
          'cuisine': 'เครื่องดื่ม ขนมหวาน',
          'hours': '08:00 - 18:00 น.',
          'image': 'https://www.nongnoochpattaya.com/r/400/auto/uploads/images/202009/a13a69a4fbdc44cfce73352184ca7842.jpg',
          'tags': 'cafe,drinks',
        },
        {
          'name': 'ครัวไทยพลับพลึง',
          'cuisine': 'อาหารไทยต้นตำรับ',
          'hours': '10:00 - 21:00 น.',
          'image': 'https://www.nongnoochpattaya.com/r/400/auto/uploads/images/202401/f99f8f4ed7279ac4b55ae8ee93581d4f.jpg',
          'tags': 'restaurant,thai',
        },
        {
          'name': 'ร้านอาหารริมสระ',
          'cuisine': 'อาหารว่าง เครื่องดื่ม',
          'hours': '09:00 - 19:00 น.',
          'image': 'https://www.nongnoochpattaya.com/r/400/auto/uploads/images/202009/c7aded86816b5c4d4f3a8cbb75b08e1b.jpg',
          'tags': 'restaurant,pool,drinks',
        },
      ];

  Widget _buildRestaurantList(BuildContext context) {
    final prov = context.watch<QuotationTypesProvider>();
    final items = _filterRestaurantsBySelected(_sampleRestaurants, prov.selected);
    return Column(
      children: items.map((r) {
        return Card(
          margin: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
          child: ListTile(
            contentPadding: const EdgeInsets.all(AppTheme.spacingMedium),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
              child: Image.network(
                r['image']!,
                width: 88,
                height: 72,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)));
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: AppTheme.lightGrey, width: 88, height: 72, child: const Icon(Icons.photo, color: AppTheme.grey));
                },
              ),
            ),
            title: Text(r['name']!),
            subtitle: Text('${r['cuisine']} • ${r['hours']}'),
            trailing: ElevatedButton(
              onPressed: () {
                // Open restaurant detail mock
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => RestaurantDetailScreen(restaurant: r)));
              },
              child: const Text('สำรอง'),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingSmall),
      child: Text(title, style: const TextStyle(fontSize: AppTheme.fontSizeTitle, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
    );
  }

  List<Map<String, String>> _filterRestaurantsBySelected(List<Map<String, String>> items, QuotationType? selected) {
    if (selected == null) return items;
    final kw = (selected.nameTh + ' ' + selected.nameEn).toLowerCase();
    final wanted = <String>{};
    if (kw.contains('cafe') || kw.contains('กาแฟ')) wanted.add('cafe');
    if (kw.contains('buffet') || kw.contains('บุฟเฟ่ต์')) wanted.add('buffet');
    if (kw.contains('banquet') || kw.contains('จัดเลี้ยง') || kw.contains('catering')) wanted.add('banquet');
    if (kw.contains('restaurant') || kw.contains('ภัตตาคาร') || kw.contains('อาหาร')) wanted.add('restaurant');
    if (wanted.isEmpty) return items;
    return items.where((e){
      final tags = (e['tags'] ?? '').split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toSet();
      return tags.intersection(wanted).isNotEmpty;
    }).toList();
  }

  Widget _buildTypesChips(BuildContext context) {
    return Consumer<QuotationTypesProvider>(
      builder: (context, prov, _) {
        if (prov.loading && prov.types.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(AppTheme.spacingMedium),
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }
        if (prov.error != null && prov.types.isEmpty) {
          return Row(
            children: [
              const Icon(Icons.error_outline, color: AppTheme.primaryRed),
              const SizedBox(width: AppTheme.spacingSmall),
              Expanded(child: Text(prov.error!, style: const TextStyle(color: AppTheme.primaryRed))),
              TextButton(onPressed: prov.fetchTypes, child: const Text('ลองใหม่')),
            ],
          );
        }
        final items = prov.diningTypes;
        if (items.isEmpty) {
          return const Text('ไม่มีข้อมูลหมวดหมู่ร้านอาหาร/จัดเลี้ยงจาก API');
        }
        return SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final t = items[index];
              return Chip(
                label: Text(t.nameTh.isNotEmpty ? t.nameTh : t.nameEn),
                backgroundColor: AppTheme.lightGrey.withAlpha(60),
              );
            },
          ),
        );
      },
    );
  }
}
