import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

/// All Zones/Attractions Screen - แสดงโซนท่องเที่ยวทั้งหมด
class AllZonesScreen extends StatelessWidget {
  const AllZonesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final zones = [
      {
        'title': 'สวนลอยฟ้า',
        'subtitle': 'สะพานกระจกชมวิวพาโนรามา',
        'image': 'https://www.nongnoochpattaya.com/r/400/auto/uploads/images/202009/a13a69a4fbdc44cfce73352184ca7842.jpg',
        'icon': Icons.park,
      },
      {
        'title': 'หุบเขาไดโนเสาร์',
        'subtitle': 'จุดเช็คอินยอดนิยม',
        'image': 'https://www.nongnoochpattaya.com/uploads/images/202011/783dc305a7cca40fd0923e609d520b7e.jpg',
        'icon': Icons.terrain,
      },
      {
        'title': 'สวนพฤกษศาสตร์',
        'subtitle': 'ชมพรรณไม้นานาชนิด',
        'image': 'https://www.nongnoochpattaya.com/r/400/auto/uploads/images/202009/a13a69a4fbdc44cfce73352184ca7842.jpg',
        'icon': Icons.local_florist,
      },
      {
        'title': 'สวนดอกไม้พญานาค',
        'subtitle': 'สวนดอกไม้สุดอลังการ',
        'image': 'https://www.nongnoochpattaya.com/r/400/auto/uploads/images/202009/c7aded86816b5c4d4f3a8cbb75b08e1b.jpg',
        'icon': Icons.nature,
      },
      {
        'title': 'กวนเกษียรสมุทร',
        'subtitle': 'ประติมากรรมตัวแทนพระพุทธศาสนา',
        'image': 'https://www.nongnoochpattaya.com/r/400/auto/uploads/images/202401/775c4b6d6fabf8fc6388d38c2d8bf0e3.jpg',
        'icon': Icons.temple_buddhist,
      },
      {
        'title': 'สวนกระบองเพชร',
        'subtitle': 'กระบองเพชรหลากหลายสายพันธุ์',
        'image': 'assets/images/S__3907804.jpg',
        'icon': Icons.yard,
      },
      {
        'title': 'สวนหินและน้ำตก',
        'subtitle': 'ธรรมชาติสงบร่มรื่น',
        'image': 'https://www.nongnoochpattaya.com/r/400/auto/uploads/images/202009/a13a69a4fbdc44cfce73352184ca7842.jpg',
        'icon': Icons.water,
      },
      {
        'title': 'โชว์ช้างและวัฒนธรรม',
        'subtitle': 'การแสดงช้างและศิลปะไทย',
        'image': 'https://www.nongnoochpattaya.com/uploads/images/202011/783dc305a7cca40fd0923e609d520b7e.jpg',
        'icon': Icons.theater_comedy,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('โซนท่องเที่ยวทั้งหมด'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(AppTheme.spacingMedium),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: zones.length,
          itemBuilder: (context, index) {
            final zone = zones[index];
            return GestureDetector(
              onTap: () {
                // TODO: Navigate to zone detail screen
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('เปิดรายละเอียด ${zone['title']}')),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.grey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(AppTheme.borderRadiusLarge),
                          ),
                          child: _buildResponsiveImage(zone['image']! as String, height: 140),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryRed.withOpacity(0.9),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              zone['icon'] as IconData,
                              color: AppTheme.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            zone['title']! as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            zone['subtitle']! as String,
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
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
          return Container(
            height: height ?? 120,
            color: AppTheme.lightGrey,
            child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        },
        errorBuilder: (c, e, st) => Container(
          height: height ?? 120,
          color: AppTheme.lightGrey,
          child: const Icon(Icons.photo, size: 40),
        ),
      );
    }

    // Local asset
    return Image.asset(
      src,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (c, e, st) => Container(
        height: height ?? 120,
        color: AppTheme.lightGrey,
        child: const Icon(Icons.photo, size: 40),
      ),
    );
  }
}
