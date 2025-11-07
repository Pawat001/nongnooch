import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Mock Authentication Provider
/// Manages login state, user info, and KYC status
class AuthProvider extends ChangeNotifier {
  AuthProvider();

  bool _isLoggedIn = false;
  String? _userId;
  String? _userName;
  String? _email;
  DateTime? _birthday;
  String? _idNumber; // KYC: ID card or passport
  bool _kycVerified = false;

  bool get isLoggedIn => _isLoggedIn;
  String? get userId => _userId;
  String? get userName => _userName;
  String? get email => _email;
  DateTime? get birthday => _birthday;
  String? get idNumber => _idNumber;
  bool get kycVerified => _kycVerified;

  /// Load saved auth state from SharedPreferences
  Future<void> loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('auth_isLoggedIn') ?? false;
    _userId = prefs.getString('auth_userId');
    _userName = prefs.getString('auth_userName');
    _email = prefs.getString('auth_email');
    final bdayStr = prefs.getString('auth_birthday');
    if (bdayStr != null) {
      _birthday = DateTime.tryParse(bdayStr);
    }
    _idNumber = prefs.getString('auth_idNumber');
    _kycVerified = prefs.getBool('auth_kycVerified') ?? false;
    notifyListeners();
  }

  /// Mock login (accept any email/password for demo)
  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network
    _isLoggedIn = true;
    _userId = 'user_${email.hashCode}';
    _userName = email.split('@').first;
    _email = email;
    await _saveAuthState();
    notifyListeners();
  }

  /// Mock register
  Future<void> register({
    required String email,
    required String password,
    required String name,
    DateTime? birthday,
    String? idNumber,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    _isLoggedIn = true;
    _userId = 'user_${email.hashCode}';
    _userName = name;
    _email = email;
    _birthday = birthday;
    _idNumber = idNumber;
    _kycVerified = (idNumber != null && idNumber.isNotEmpty);
    await _saveAuthState();
    notifyListeners();
  }

  /// Logout
  Future<void> logout() async {
    _isLoggedIn = false;
    _userId = null;
    _userName = null;
    _email = null;
    _birthday = null;
    _idNumber = null;
    _kycVerified = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }

  Future<void> _saveAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('auth_isLoggedIn', _isLoggedIn);
    if (_userId != null) await prefs.setString('auth_userId', _userId!);
    if (_userName != null) await prefs.setString('auth_userName', _userName!);
    if (_email != null) await prefs.setString('auth_email', _email!);
    if (_birthday != null) await prefs.setString('auth_birthday', _birthday!.toIso8601String());
    if (_idNumber != null) await prefs.setString('auth_idNumber', _idNumber!);
    await prefs.setBool('auth_kycVerified', _kycVerified);
  }
}
