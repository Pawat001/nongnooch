import 'package:flutter/material.dart';
// provider removed: quotation types moved to Home
import '../utils/app_theme.dart';
import '../localization/app_localizations.dart';
import 'ticket_detail_screen.dart';

/// Tickets Screen - หน้าจองตั๋วเข้าชม
class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Previously the quotation types were fetched here; moved to HomeScreen
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          // No-op refresh for tickets (quotation types moved to Home)
          return;
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppTheme.spacingMedium),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero / intro
            Row(
              children: [
                SizedBox(
                  width: 110,
                  height: 110,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://s.isanook.com/tr/0/ui/287/1435317/S__3907804.jpg',
                      fit: BoxFit.cover,
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
                            child: Icon(Icons.photo, color: AppTheme.grey, size: 40),
                          ),
                        );
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
                        localization?.ticketBooking ?? 'จองตั๋วเข้าชม',
                        style: const TextStyle(
                          fontSize: AppTheme.fontSizeTitle,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'เลือกบัตรที่เหมาะกับคุณ — เด็ก, ผู้ใหญ่, และแพ็กเกจครอบครัว',
                        style: const TextStyle(color: AppTheme.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingLarge),

            // (Quotation types moved to Home screen)

            // Sample ticket list (local mock)
            _buildSectionTitle(localization?.recommendedAttractions ?? 'บัตรแนะนำ'),
            const SizedBox(height: AppTheme.spacingSmall),
            _buildTicketList(context),
          ],
        ),
      ),
    ),
  );
  }

  // TODO: ข้อมูลจริงจากเว็บ https://www.nongnoochpattaya.com/th/ - ควรดึงจาก API
  List<Map<String, dynamic>> get _sampleTickets => [
        {
          'title': 'บัตรเข้าชมสวนนงนุชพัทยา (ผู้ใหญ่)',
          'subtitle': 'เที่ยวสวนสวย หุบเขาไดโนเสาร์ สวนพฤกษศาสตร์ ชมโชว์',
          'price': '฿600',
          'image': 'https://static.ticket2attraction.com/gallery/8772d14a-04e9-42a3-a6eb-266cc908a5d1/e4de1ac8-bc87-4f9b-9249-45f001f3ed53-1200.webp',
          'tags': ['tour','ticket'],
        },
        {
          'title': 'บัตรเข้าชมเด็ก (4-12 ปี)',
          'subtitle': 'ส่วนลดพิเศษสำหรับเด็ก เข้าชมได้ทั้งวัน',
          'price': '฿350',
          'image': 'https://static.ticket2attraction.com/gallery/6296d3d7-7c8a-4b9b-85a5-0367d31c7152/bf8b6f3d-70a0-4402-b408-6e5034406d41-1200.webp',
          'tags': ['tour','family','ticket'],
        },
        {
          'title': 'แพ็คเกจสวนนงนุชพัทยา',
          'subtitle': 'ตั๋ว + รถราง + บุฟเฟ่ต์ ครบจบในที่เดียว',
          'price': '฿1,299',
          'image': 'https://static.ticket2attraction.com/gallery/9e9ed3e7-7151-4b74-aed8-114169e79220/f44aef4a-3020-4cca-8721-6342353cef6f-1200.webp',
          'tags': ['package','tour','dining'],
        },
        {
          'title': 'โปรโมชั่นพิเศษ มา 3 จ่าย 2',
          'subtitle': 'คุ้มสุด! พาเพื่อนมา 3 คน จ่ายเพียง 2 คน',
          'price': '฿1,200',
          'image': 'https://static.ticket2attraction.com/59becfd8-e3ce-487e-8e6f-ea85782d1df0.jpg',
          'tags': ['promo','ticket'],
        },
      ];

  Widget _buildTicketList(BuildContext context) {
    final filtered = _sampleTickets;
    return Column(
      children: [
        for (final t in filtered)
          Card(
            margin: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
            child: ListTile(
              contentPadding: const EdgeInsets.all(AppTheme.spacingMedium),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                child: Image.network(
                  t['image'] as String,
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
              title: Text(t['title'] as String),
              subtitle: Text(t['subtitle'] as String),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(t['price'] as String, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryRed)),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Open mock ticket detail / booking
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (ctx) => TicketDetailScreen(ticket: t.cast<String, String>())),
                      );
                    },
                    style: ElevatedButton.styleFrom(minimumSize: const Size(88, 36)),
                    child: const Text('จอง'),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

    // Note: filtering by quotation types moved to HomeScreen; Tickets now shows the local sample list

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingSmall),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: AppTheme.fontSizeTitle,
          fontWeight: FontWeight.bold,
          color: AppTheme.textPrimary,
        ),
      ),
    );
  }
}
