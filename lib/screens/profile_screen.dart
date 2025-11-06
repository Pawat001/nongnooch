import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../localization/app_localizations.dart';
// Mock / demo screens
import 'login_screen.dart';
import 'register_screen.dart';
import 'bookings_screen.dart';
import 'settings_screen.dart';
import 'kyc_screen.dart';
import 'about_screen.dart';

/// Profile Screen - หน้าโปรไฟล์ผู้ใช้
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

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
                  // Profile image placeholder from the web.
                  // TODO: Replace with asset: assets/images/profile_avatar.jpg or use user's uploaded photo
                  // Use an explicit network image with fallback inside a circular clip
                  ClipOval(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        'https://source.unsplash.com/featured/?portrait,person',
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
                            color: AppTheme.white,
                            child: const Center(
                              child: Icon(Icons.person, size: 48, color: AppTheme.primaryRed),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingMedium),
                  const Text(
                    'ผู้ใช้งาน Guest',
                    style: TextStyle(
                      fontSize: AppTheme.fontSizeLarge,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.white,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingSmall),
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
                      style: TextStyle(
                        color: AppTheme.white,
                        fontSize: AppTheme.fontSizeSmall,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // Login Button -> opens mock login screen
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              icon: const Icon(Icons.login),
              label: Text(localization?.login ?? 'เข้าสู่ระบบ'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingMedium),
            
            // Register Button -> opens mock register screen
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
              icon: const Icon(Icons.person_add),
              label: Text(localization?.register ?? 'สมัครสมาชิก'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            
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
