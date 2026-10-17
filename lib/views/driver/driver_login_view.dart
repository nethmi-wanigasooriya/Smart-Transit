import 'package:flutter/material.dart';
import 'driver_dashboard_view.dart';
import '../sign_in_view.dart';

class DriverLoginView extends StatefulWidget {
  const DriverLoginView({super.key});

  @override
  State<DriverLoginView> createState() => _DriverLoginViewState();
}

class _DriverLoginViewState extends State<DriverLoginView> {
  final _driverIdController = TextEditingController(text: 'DRV-804');
  final _passwordController = TextEditingController(text: '123456');
  bool _isPasswordObscured = true;

  void _handleDriverLogin() {
    String driverId = _driverIdController.text.trim();
    String password = _passwordController.text.trim();

    if (driverId.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Driver ID mariyu Password enter cheyandi!')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Driver Portal ki Swagatham!')),
    );

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => const DriverDashboardView(),
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        title: const Row(
          children: [
            Text('🚘', style: TextStyle(fontSize: 22)),
            SizedBox(width: 10),
            Text(
              'Driver Access Portal',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF0F2C59),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignInView()),
            );
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(28.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 36,
                  backgroundColor: Color(0xFF0F2C59),
                  child: Text('👨‍✈️', style: TextStyle(fontSize: 36)),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Transit Driver Sign In',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F2C59),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Airport Shuttle & Route Operators',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 24),

                // Driver ID Input
                TextField(
                  controller: _driverIdController,
                  decoration: InputDecoration(
                    labelText: 'Driver ID / License No',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('🆔', style: TextStyle(fontSize: 18)),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),

                // Password Input
                TextField(
                  controller: _passwordController,
                  obscureText: _isPasswordObscured,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('🔒', style: TextStyle(fontSize: 18)),
                    ),
                    suffixIcon: IconButton(
                      icon: Text(_isPasswordObscured ? '👁️' : '🙈', style: const TextStyle(fontSize: 18)),
                      onPressed: () {
                        setState(() {
                          _isPasswordObscured = !_isPasswordObscured;
                        });
                      },
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 24),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F2C59),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _handleDriverLogin,
                    icon: const Text('🚘', style: TextStyle(fontSize: 18)),
                    label: const Text(
                      'Login to Driver Dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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