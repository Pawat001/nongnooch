import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_theme.dart';
import '../localization/app_localizations.dart';
import 'room_detail_screen.dart';
import '../providers/quotation_types_provider.dart';
import '../services/nongnooch_api_service.dart';

/// Rooms Screen - หน้าจองห้องพัก
class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
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
            // Intro row with image
            Row(
              children: [
                SizedBox(
                  width: 110,
                  height: 110,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://www.nongnoochpattaya.com/r/400/auto/uploads/images/202010/7f416d482dc677c6801d365e0d219eb0.jpg',
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)));
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(color: AppTheme.lightGrey, child: const Center(child: Icon(Icons.hotel, color: AppTheme.grey)));
                      },
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingMedium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localization?.roomBooking ?? 'จองห้องพัก',
                        style: const TextStyle(fontSize: AppTheme.fontSizeTitle, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      const Text('ค้นหาที่พักตามงบและสิ่งอำนวยความสะดวกที่คุณต้องการ', style: TextStyle(color: AppTheme.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingLarge),

            // Accommodation types from API
            _buildSectionTitle('หมวดหมู่ที่พัก (API)'),
            const SizedBox(height: AppTheme.spacingSmall),
            _buildTypesChips(context),
            const SizedBox(height: AppTheme.spacingLarge),

            _buildSectionTitle(localization?.rooms ?? 'ห้องพักแนะนำ'),
            const SizedBox(height: AppTheme.spacingSmall),
            _buildRoomList(context),
            ],
          ),
          ),
      ),
    );
  }

  // TODO: ข้อมูลจริงจาก https://www.nongnoochpattaya.com/th/resort - ควรดึงจาก API
  List<Map<String, dynamic>> get _sampleRooms => [
        {
          'title': 'นงนุชรีสอร์ต (Nongnooch Resort)',
          'subtitle': 'ห้องพักสไตล์โมเดิร์นทันสมัย ล้อมรอบด้วยสระว่ายน้ำ พักได้ 3 คน',
          'price': '฿2,200/คืน',
          'image': 'https://www.nongnoochpattaya.com/uploads/images/202011/783dc305a7cca40fd0923e609d520b7e.jpg',
          'features': ['สระว่ายน้ำ', 'ระเบียงส่วนตัว', 'WiFi ฟรี'],
          'tags': ['resort'],
        },
        {
          'title': 'การ์เด้น วิลล่า (Garden Villa)',
          'subtitle': 'บ้านพักสไตล์รีสอร์ท 2 ห้องนอน 2 ห้องน้ำ พักได้ 4 ท่าน',
          'price': '฿3,800/คืน (Deluxe)',
          'image': 'https://www.nongnooch.world/nongnooch-home-img/assets/resort_master_image/preview/garden_1.png',
          'features': ['2 ห้องนอน', 'ห้องนั่งเล่น', 'วิวสวน'],
          'tags': ['villa','family'],
        },
        {
          'title': 'การ์เด้น วิลล่า Superior',
          'subtitle': 'บ้านพักท่ามกลางธรรมชาติ 2 ห้องนอน เหมาะสำหรับครอบครัว',
          'price': '฿3,200/คืน',
          'image': 'https://www.nongnooch.world/nongnooch-home-img/assets/room_type_image/nongnooch_resort/Standard_room/1_2.png',
          'features': ['2 ห้องนอน', '2 ห้องน้ำ', 'ครัว'],
          'tags': ['villa','family'],
        },
        {
          'title': 'ริมน้ำ วิลล่า (Rimnam Villa)',
          'subtitle': 'บ้านขนาดใหญ่ 11 ห้องนอน เหมาะสำหรับกลุ่มใหญ่',
          'price': '฿18,000+/คืน',
          'image': 'https://www.nongnoochpattaya.com/uploads/images/202501/550f611fae73e911ab113b7c6b0c89f5.jpg',
          'features': ['11 ห้องนอน', 'พักได้ 22-55 คน', 'วิวริมน้ำ'],
          'tags': ['villa','group'],
        },
        {
          'title': 'นงนุช บูติค รีสอร์ท ตึก C/D',
          'subtitle': 'ที่พักสำหรับ 3 ท่าน พร้อมสิ่งอำนวยความสะดวกครบครัน',
          'price': '฿2,500/คืน',
          'image': 'https://www.nongnooch.world/nongnooch-home-img/assets/resort_master_image/preview/boutique_c_1.png',
          'features': ['WiFi', 'แอร์', 'ทีวี'],
          'tags': ['boutique','resort'],
        },
        {
          'title': 'นงนุช เทรดดิชั่น รีสอร์ท ตึก A/B',
          'subtitle': 'ห้องพัก 2-3 ท่าน ออกแบบเพื่อทุกคน Universal Design',
          'price': '฿2,000/คืน',
          'image': 'https://www.nongnooch.world/nongnooch-home-img/assets/resort_master_image/preview/tradition_a_1.png',
          'features': ['Universal Design', 'WiFi', 'สะดวกสบาย'],
          'tags': ['tradition','resort'],
        },
        {
          'title': 'เลคไซด์ วิลล่า (Lakeside Villa)',
          'subtitle': 'ห้องพักวิวทะเลทราย หุบเขา 2 ชั้น 1 ห้องนอน มีระเบียง',
          'price': '฿2,800/คืน',
          'image': 'https://www.nongnooch.world/nongnooch-home-img/assets/resort_master_image/banner/3.webp',
          'features': ['วิวทะเลทราย', 'ระเบียง', 'ห้องมุม'],
          'tags': ['villa','lakeside'],
        },
      ];

  Widget _buildRoomList(BuildContext context) {
    final prov = context.watch<QuotationTypesProvider>();
    final items = _filterRoomsBySelected(_sampleRooms, prov.selected);
    return Column(
      children: items.map((r) {
        return Card(
          margin: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
          child: Column(
            children: [
              SizedBox(
                height: 160,
                width: double.infinity,
                child: Image.network(
                  r['image'],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)));
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(color: AppTheme.lightGrey, child: const Center(child: Icon(Icons.bed, color: AppTheme.grey)));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppTheme.spacingMedium),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Text(r['subtitle'], style: const TextStyle(color: AppTheme.textSecondary)),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: (r['features'] as List<String>).map((f) => Chip(label: Text(f), backgroundColor: AppTheme.primaryRed.withAlpha(20))).toList(),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(r['price'], style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryRed)),
                        const SizedBox(height: 8),
                        ElevatedButton(onPressed: () {
                          // Open room detail mock
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) => RoomDetailScreen(room: r)));
                        }, child: const Text('จอง'))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingSmall),
      child: Text(
        title,
        style: const TextStyle(fontSize: AppTheme.fontSizeTitle, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
      ),
    );
  }

  List<Map<String, dynamic>> _filterRoomsBySelected(List<Map<String, dynamic>> items, QuotationType? selected) {
    if (selected == null) return items;
    final kw = (selected.nameTh + ' ' + selected.nameEn).toLowerCase();
    final Set<String> wanted = {};
    if (kw.contains('villa') || kw.contains('วิลล่า')) wanted.add('villa');
    if (kw.contains('resort') || kw.contains('รีสอร์ท') || kw.contains('ที่พัก') || kw.contains('accommodation')) wanted.addAll({'resort','boutique','tradition'});
    if (kw.contains('lakeside') || kw.contains('ริมน้ำ')) wanted.add('lakeside');
    if (kw.contains('seminar') || kw.contains('สัมมน') || kw.contains('กลุ่ม')) wanted.add('group');
    if (wanted.isEmpty) return items;
    return items.where((e){
      final tags = (e['tags'] as List?)?.cast<String>().toSet() ?? {};
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
        final items = prov.accommodationTypes;
        if (items.isEmpty) {
          return const Text('ไม่มีข้อมูลหมวดหมู่ที่พักจาก API');
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
                backgroundColor: AppTheme.primaryRed.withAlpha(24),
              );
            },
          ),
        );
      },
    );
  }
}
