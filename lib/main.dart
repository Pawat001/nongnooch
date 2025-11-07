import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'providers/language_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/quotation_types_provider.dart';
import 'providers/auth_provider.dart';
import 'localization/app_localizations.dart';
import 'utils/app_theme.dart';
import 'screens/main_navigation_screen.dart';

/// สวนนงนุช One-Stop Service App
/// 
/// แอปพลิเคชัน One-Stop Service สำหรับสวนนงนุชพัทยา
/// รวมศูนย์บริการจองตั๋ว, ห้องพัก, และร้านอาหาร
/// 
/// Features:
/// - จองตั๋วเข้าชมพร้อมระบบคำนวณราคาแบบไดนามิก
/// - จองห้องพักพร้อมปฏิทินห้องว่างและระบบเลือกหมายเลขห้อง
/// - จองร้านอาหารพร้อมระบบสั่งอาหารล่วงหน้า
/// - ตะกร้าสินค้ารวมสำหรับทุกบริการ
/// - ระบบ KYC และโปรโมชั่นวันเกิดอัตโนมัติ
/// - รองรับ 2 ภาษา: ไทย/อังกฤษ
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize providers
  final languageProvider = LanguageProvider();
  final cartProvider = CartProvider();
  final authProvider = AuthProvider();
  
  // Load saved data
  await languageProvider.loadSavedLanguage();
  await cartProvider.loadCart();
  await authProvider.loadAuthState();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: languageProvider),
        ChangeNotifierProvider.value(value: cartProvider),
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider(create: (_) => QuotationTypesProvider()),
      ],
      child: const SuanNongNuchApp(),
    ),
  );
}

class SuanNongNuchApp extends StatelessWidget {
  const SuanNongNuchApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      // App Info
      title: 'สวนนงนุช One-Stop Service',
      debugShowCheckedModeBanner: false,
      
      // Theme
      theme: AppTheme.lightTheme,
      
      // Localization
      locale: languageProvider.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('th', 'TH'),
        Locale('en', 'US'),
      ],
      
      // Home Screen
      home: const MainNavigationScreen(),
    );
  }
}
