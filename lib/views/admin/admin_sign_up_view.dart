import 'package:flutter/material.dart';
import 'admin_login_view.dart';

class AdminSignUpView extends StatefulWidget {
  const AdminSignUpView({super.key});

  // Shared state to hold registered credentials
  static String registeredAdminEmail = "";
  static String registeredAdminPassword = "";

  @override
  State<AdminSignUpView> createState() => _AdminSignUpViewState();
}

class _AdminSignUpViewState extends State<AdminSignUpView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _adminCodeController = TextEditingController();
  bool _obscurePassword = true;

  void _registerAdmin() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final adminCode = _adminCodeController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || adminCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Save Admin Credentials
    AdminSignUpView.registeredAdminEmail = email;
    AdminSignUpView.registeredAdminPassword = password;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Admin Registered Successfully! Please Log In.'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AdminLoginView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        title: const Text('Register Admin', style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: const Color(0xFF0F2C59),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Create Admin Account',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F2C59)),
                ),
                const SizedBox(height: 20),

                // Full Name
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: const Padding(padding: EdgeInsets.all(12.0), child: Text('👤', style: TextStyle(fontSize: 20))),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                const SizedBox(height: 16),

                // Admin Email
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Admin Email',
                    prefixIcon: const Padding(padding: EdgeInsets.all(12.0), child: Text('📧', style: TextStyle(fontSize: 20))),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                const SizedBox(height: 16),

                // Secret Security Key
                TextField(
                  controller: _adminCodeController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Admin Security Key',
                    prefixIcon: const Padding(padding: EdgeInsets.all(12.0), child: Text('🛡️', style: TextStyle(fontSize: 20))),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                const SizedBox(height: 16),

                // Password
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Padding(padding: EdgeInsets.all(12.0), child: Text('🔑', style: TextStyle(fontSize: 20))),
                    suffixIcon: IconButton(
                      icon: Text(_obscurePassword ? '👁️' : '🙈', style: const TextStyle(fontSize: 18)),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F2C59),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: _registerAdmin,
                    child: const Text('Register Admin Account', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}