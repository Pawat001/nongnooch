import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import 'register_screen.dart';

/// Mock Login Screen (username / password) used for profile mockup
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logged in as ${_usernameController.text}')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เข้าสู่ระบบ')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppTheme.spacingLarge),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username / Email'),
              ),
              const SizedBox(height: AppTheme.spacingMedium),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: AppTheme.spacingLarge),
              ElevatedButton(
                onPressed: _loading ? null : _submit,
                child: _loading ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.white)) : const Text('เข้าสู่ระบบ'),
              ),
              const SizedBox(height: AppTheme.spacingSmall),
              TextButton(
                onPressed: () {
                  // go to mock register screen
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterScreen()));
                },
                child: const Text('ยังไม่ได้เป็นสมาชิก? สมัครเลย'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
