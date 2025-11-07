import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../utils/app_theme.dart';
import '../localization/app_localizations.dart';
// Mock / demo screens
import 'login_screen.dart';
import 'register_screen.dart';
import 'bookings_screen.dart';
import 'settings_screen.dart';
import 'kyc_screen.dart';
import 'about_screen.dart';

/// Profile Screen - หน้าโปรไฟล์ผู้ใช้ with Auth integration
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final authProvider = context.watch<AuthProvider>();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingLarge),
              decoration: BoxDecoration(
                gradient: AppTheme.redGoldGradient,
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
              ),
              child: Column(
                children: [
                  // Profile image placeholder
                  ClipOval(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: authProvider.isLoggedIn
                          ? Image.network(
                              'https://source.unsplash.com/featured/?portrait,person',
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: AppTheme.white,
                                child: const Icon(Icons.person, size: 48, color: AppTheme.primaryRed),
                              ),
                            )
                          : Container(
                              color: AppTheme.white,
                              child: const Icon(Icons.person, size: 48, color: AppTheme.primaryRed),
                            ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingMedium),
                  Text(
                    authProvider.isLoggedIn
                        ? authProvider.userName ?? 'ผู้ใช้งาน'
                        : 'ผู้ใช้งาน Guest',
                    style: const TextStyle(
                      fontSize: AppTheme.fontSizeLarge,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.white,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingSmall),
                  if (authProvider.isLoggedIn) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingMedium,
                        vertical: AppTheme.spacingSmall,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withAlpha(153),
                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                      ),
                      child: Text(
                        authProvider.email ?? '',
                        style: const TextStyle(color: AppTheme.white, fontSize: AppTheme.fontSizeSmall),
                      ),
                    ),
                    if (authProvider.kycVerified) ...[
                      const SizedBox(height: AppTheme.spacingSmall),
                      const Chip(
                        avatar: Icon(Icons.verified, color: Colors.white, size: 16),
                        label: Text('ยืนยันตัวตนแล้ว (KYC)', style: TextStyle(color: Colors.white, fontSize: 12)),
                        backgroundColor: Colors.green,
                      ),
                    ],
                  ] else
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingMedium,
                        vertical: AppTheme.spacingSmall,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.white.withAlpha(51),
                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                      ),
                      child: const Text(
                        'ยังไม่ได้เข้าสู่ระบบ',
                        style: TextStyle(color: AppTheme.white, fontSize: AppTheme.fontSizeSmall),
                      ),
                    ),
                ],
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // Login/Logout Buttons
            if (!authProvider.isLoggedIn) ...[
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                icon: const Icon(Icons.login),
                label: Text(localization?.login ?? 'เข้าสู่ระบบ'),
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              ),
              const SizedBox(height: AppTheme.spacingMedium),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterScreen()),
                  );
                },
                icon: const Icon(Icons.person_add),
                label: Text(localization?.register ?? 'สมัครสมาชิก'),
                style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              ),
            ] else ...[
              OutlinedButton.icon(
                onPressed: () async {
                  await authProvider.logout();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('ออกจากระบบสำเร็จ')),
                    );
                  }
                },
                icon: const Icon(Icons.logout, color: AppTheme.error),
                label: const Text('ออกจากระบบ', style: TextStyle(color: AppTheme.error)),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: const BorderSide(color: AppTheme.error),
                ),
              ),
            ],
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // Menu List
            _buildMenuCard(
              context,
              Icons.book_outlined,
              localization?.myBookings ?? 'การจองของฉัน',
              'ดูประวัติการจองทั้งหมด',
              const BookingsScreen(),
            ),
            _buildMenuCard(
              context,
              Icons.settings_outlined,
              localization?.settings ?? 'ตั้งค่า',
              'จัดการการตั้งค่าบัญชี',
              const SettingsScreen(),
            ),
            _buildMenuCard(
              context,
              Icons.verified_user_outlined,
              localization?.kycVerification ?? 'ยืนยันตัวตน (KYC)',
              'ยืนยันตัวตนเพื่อรับสิทธิพิเศษ',
              const KycScreen(),
            ),
            _buildMenuCard(
              context,
              Icons.info_outline,
              'เกี่ยวกับเรา',
              'ข้อมูลเกี่ยวกับสวนนงนุช',
              const AboutScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, IconData icon, String title, String subtitle, Widget destination) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(AppTheme.spacingSmall),
          decoration: BoxDecoration(
            color: AppTheme.primaryRed.withAlpha(26),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
          ),
          child: Icon(icon, color: AppTheme.primaryRed),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: AppTheme.fontSizeNormal,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
      ),
    );
  }
}
