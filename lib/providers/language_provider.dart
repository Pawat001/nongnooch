import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

/// Language Provider สำหรับจัดการการสลับภาษา TH/EN
class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('th', 'TH');
  
  Locale get locale => _locale;
  
  bool get isThaiLanguage => _locale.languageCode == AppConstants.langThai;
  bool get isEnglishLanguage => _locale.languageCode == AppConstants.langEnglish;
  
  /// Initialize language from SharedPreferences
  Future<void> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString(AppConstants.keyLanguage);
    
    if (savedLang != null) {
      if (savedLang == AppConstants.langThai) {
        _locale = const Locale('th', 'TH');
      } else if (savedLang == AppConstants.langEnglish) {
        _locale = const Locale('en', 'US');
      }
      notifyListeners();
    }
  }
  
  /// Change language and save to SharedPreferences
  Future<void> changeLanguage(String languageCode) async {
    if (languageCode == AppConstants.langThai) {
      _locale = const Locale('th', 'TH');
    } else if (languageCode == AppConstants.langEnglish) {
      _locale = const Locale('en', 'US');
    }
    
    // Save to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.keyLanguage, languageCode);
    
    notifyListeners();
  }
  
  /// Toggle between Thai and English
  Future<void> toggleLanguage() async {
    if (isThaiLanguage) {
      await changeLanguage(AppConstants.langEnglish);
    } else {
      await changeLanguage(AppConstants.langThai);
    }
  }
}
