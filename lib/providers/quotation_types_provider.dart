import 'package:flutter/foundation.dart';
import '../services/nongnooch_api_service.dart';

class QuotationTypesProvider extends ChangeNotifier {
  QuotationTypesProvider({NongnoochApiService? api}) : _api = api ?? NongnoochApiService();

  final NongnoochApiService _api;

  List<QuotationType> _types = [];
  bool _loading = false;
  String? _error;
  bool _initialized = false;
  QuotationType? _selected;

  List<QuotationType> get types => _types;
  bool get loading => _loading;
  String? get error => _error;
  QuotationType? get selected => _selected;

  // Derived category groupings
  List<QuotationType> get accommodationTypes {
    final needles = ['ที่พัก', 'accommodation', 'stay', 'resort', 'villa'];
    return _types.where((t) => _matchesAny(t, needles)).toList();
  }

  List<QuotationType> get diningTypes {
    final needles = ['จัดเลี้ยง', 'ภัตตาคาร', 'ร้านอาหาร', 'อาหาร', 'catering', 'banquet', 'restaurant', 'cafe'];
    return _types.where((t) => _matchesAny(t, needles)).toList();
  }

  List<QuotationType> get visitOrTicketTypes {
    final needles = ['tour', 'one day', 'ศึกษาดูงาน', 'สัมมนา', 'ฝึกอบรม', 'training', 'seminar', 'ticket'];
    return _types.where((t) => _matchesAny(t, needles)).toList();
  }

  bool _matchesAny(QuotationType t, List<String> needles) {
    final th = t.nameTh.toLowerCase();
    final en = t.nameEn.toLowerCase();
    for (final n in needles) {
      final nn = n.toLowerCase();
      if (th.contains(nn) || en.contains(nn)) return true;
    }
    return false;
  }

  Future<void> ensureLoaded() async {
    if (_initialized || _loading) return;
    _initialized = true;
    await fetchTypes();
  }

  Future<void> fetchTypes() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final result = await _api.getQuotationDetailTypes();
      _types = result;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void setSelected(QuotationType? value) {
    _selected = value;
    notifyListeners();
  }
}
