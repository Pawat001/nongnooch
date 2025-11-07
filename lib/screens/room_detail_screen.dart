import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../utils/app_theme.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item_model.dart';

class RoomDetailScreen extends StatefulWidget {
  final Map<String, dynamic> room;

  const RoomDetailScreen({super.key, required this.room});

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

  String _formatDate(DateTime? d) {
    if (d == null) return '-';
    return DateFormat('dd MMM yyyy').format(d);
  }

  @override
  Widget build(BuildContext context) {
    final room = widget.room;
    final features = (room['features'] as List<dynamic>?)?.cast<String>() ?? <String>[];

    return Scaffold(
      appBar: AppBar(title: Text(room['title'] ?? 'Room')),
      body: SafeArea(
        child: SingleChildScrollView(
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

                    // Calendar (range selection)
                    _buildCalendar(),
                    const SizedBox(height: AppTheme.spacingSmall),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('เช็คอิน: ${_formatDate(_rangeStart)}', style: const TextStyle(color: AppTheme.textSecondary)),
                        Text('เช็คเอาท์: ${_formatDate(_rangeEnd)}', style: const TextStyle(color: AppTheme.textSecondary)),
                      ],
                    ),

                    const SizedBox(height: AppTheme.spacingLarge),
                    Text(room['price'] ?? '', style: const TextStyle(fontSize: AppTheme.fontSizeLarge, fontWeight: FontWeight.bold, color: AppTheme.primaryRed)),
                    const SizedBox(height: AppTheme.spacingLarge),
                    ElevatedButton(
                      onPressed: () async {
                        // Validate date range
                        if (_rangeStart == null || _rangeEnd == null) {
                          await showDialog<void>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('เลือกวันที่'),
                              content: const Text('กรุณาเลือกวันที่เช็คอินและเช็คเอาท์ก่อนจอง'),
                              actions: [
                                TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('ตกลง')),
                              ],
                            ),
                          );
                          return;
                        }

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
                          metadata: {
                            'features': room['features'],
                            'checkIn': _rangeStart?.toIso8601String(),
                            'checkOut': _rangeEnd?.toIso8601String(),
                          },
                        );

                        await cartProvider.addItem(item);

                        if (!context.mounted) return;
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
      ),
    );
  }

  Widget _buildCalendar() {
    final first = DateTime.now().subtract(const Duration(days: 0));
    final last = DateTime.now().add(const Duration(days: 365));
    return TableCalendar(
      firstDay: first,
      lastDay: last,
      focusedDay: _focusedDay,
      headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(color: Color(0x00FF0000)),
      ),
      rangeSelectionMode: _rangeSelectionMode,
      onRangeSelected: (start, end, focusedDay) {
        setState(() {
          _rangeStart = start;
          _rangeEnd = end;
          _focusedDay = focusedDay;
          _rangeSelectionMode = RangeSelectionMode.toggledOn;
        });
      },
      selectedDayPredicate: (day) => false,
    );
  }
}
