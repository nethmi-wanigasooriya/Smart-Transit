import 'package:flutter/material.dart';
import '../sign_in_view.dart';

class DriverDashboardView extends StatefulWidget {
  final String userName;
  final String userEmail;

  const DriverDashboardView({
    super.key,
    this.userName = 'Driver User',
    this.userEmail = 'driver@smarttransit.com',
  });

  @override
  State<DriverDashboardView> createState() => _DriverDashboardViewState();
}

class _DriverDashboardViewState extends State<DriverDashboardView> {
  late String _currentName;
  late String _currentEmail;
  
  bool _isTripStarted = false;
  int _passengerCount = 0;

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

  @override
  void initState() {
    super.initState();
    _currentName = widget.userName;
    _currentEmail = widget.userEmail;
  }

  @override
  void didUpdateWidget(covariant DriverDashboardView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.userName != widget.userName || oldWidget.userEmail != widget.userEmail) {
      setState(() {
        _currentName = widget.userName;
        _currentEmail = widget.userEmail;
      });
    }
  }

  void _handleLogout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInView()),
      (route) => false,
    );
  }

  void _incrementPassenger() {
    setState(() {
      _passengerCount++;
    });
  }

  void _decrementPassenger() {
    if (_passengerCount > 0) {
      setState(() {
        _passengerCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Row(
          children: [
            _buildCleanIcon('🚘', size: 22, color: Colors.white),
            const SizedBox(width: 10),
            const Text(
              'Driver Dashboard Portal',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF0F2A4A),
        elevation: 0,
        actions: [
          IconButton(
            icon: _buildCleanIcon('🚪', size: 20, color: Colors.white),
            tooltip: 'Logout',
            onPressed: _handleLogout,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Driver Details Banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0F2A4A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: _buildCleanIcon('👨‍✈️', size: 30),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentName,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _currentEmail,
                          style: const TextStyle(fontSize: 12, color: Colors.white70),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.green.shade600,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text('Active Driver Operator', style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Trip Control
            const Text('Trip Control', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F2A4A))),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Route Status:', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F2A4A))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          _isTripStarted ? '⏸️ Trip Active' : '⏸️ Trip Paused / Ready',
                          style: TextStyle(fontSize: 11, color: Colors.orange.shade900, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F2A4A),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        setState(() {
                          _isTripStarted = !_isTripStarted;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(_isTripStarted ? 'Trip Started' : 'Trip Paused')),
                        );
                      },
                      icon: _buildCleanIcon('🚀', size: 18, color: Colors.white),
                      label: Text(
                        _isTripStarted ? 'Pause Trip & Route' : 'Start Trip & Route',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Passenger Manifest Counter Section
            const Text('Passenger Manifest Counter', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F2A4A))),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Boarded Passengers', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text('$_passengerCount Count', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F2A4A))),
                    ],
                  ),
                  Row(
                    children: [
                      // Fixed Decrement Button (-)
                      InkWell(
                        onTap: _decrementPassenger,
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: _buildCleanIcon('➖', size: 16, color: const Color(0xFF0F2A4A)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Fixed Increment Button (+)
                      InkWell(
                        onTap: _incrementPassenger,
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: const BoxDecoration(
                            color: Color(0xFF0F2A4A),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: _buildCleanIcon('➕', size: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Emergency Alert Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Emergency Alert Triggered! Notification sent to control room.')),
                  );
                },
                icon: _buildCleanIcon('🚨', size: 18, color: Colors.white),
                label: const Text('Trigger Emergency Alert', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 28),

            // Dedicated Logout Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade800,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _handleLogout,
                icon: _buildCleanIcon('🚪', size: 20, color: Colors.white),
                label: const Text(
                  'Log Out Driver Account',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}