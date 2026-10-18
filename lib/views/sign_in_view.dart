import 'package:flutter/material.dart';
import 'passenger/home_view.dart';
import 'driver/driver_dashboard_view.dart';
import 'admin/admin_dashboard_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  bool _isSignUp = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'Passenger'; // Passenger, Driver, Admin

  final List<String> _roles = ['Passenger', 'Driver', 'Admin'];

  Widget _buildCleanIcon(String symbol, {double size = 20, Color color = const Color(0xFF1E3A8A)}) {
    return Text(
      symbol,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void _handleSubmit() {
    final name = _nameController.text.trim().isEmpty 
        ? (_isSignUp ? 'New User' : (_selectedRole == 'Driver' ? 'Driver User' : (_selectedRole == 'Admin' ? 'Admin User' : 'Passenger User')))
        : _nameController.text.trim();
    final email = _emailController.text.trim().isEmpty 
        ? 'user@smarttransit.com' 
        : _emailController.text.trim();

    if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid email and password')),
      );
      return;
    }

    if (_selectedRole == 'Passenger') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeView(
            userName: name,
            userEmail: email,
          ),
        ),
      );
    } else if (_selectedRole == 'Driver') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DriverDashboardView(
            userName: name,
            userEmail: email,
          ),
        ),
      );
    } else if (_selectedRole == 'Admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AdminDashboardView(
            userName: name,
            userEmail: email,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 420),
            padding: const EdgeInsets.all(28.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E3A8A).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: _buildCleanIcon('🚍', size: 36),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Smart Transit App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _isSignUp ? 'Create a new account' : 'Sign in to continue',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 24),

                if (_isSignUp) ...[
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: Center(widthFactor: 1, child: _buildCleanIcon('👤', size: 18)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: Center(widthFactor: 1, child: _buildCleanIcon('✉️', size: 18)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Center(widthFactor: 1, child: _buildCleanIcon('🔒', size: 18)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  value: _selectedRole,
                  decoration: InputDecoration(
                    labelText: 'Select Role',
                    prefixIcon: Center(widthFactor: 1, child: _buildCleanIcon('🎭', size: 18)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: _roles.map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedRole = val!;
                    });
                  },
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _handleSubmit,
                  child: Text(
                    _isSignUp ? 'Sign Up' : 'Sign In',
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    setState(() {
                      _isSignUp = !_isSignUp;
                    });
                  },
                  child: Text(
                    _isSignUp ? 'Already have an account? Sign In' : "Don't have an account? Sign Up",
                    style: const TextStyle(color: Color(0xFF1E3A8A), fontWeight: FontWeight.w600),
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