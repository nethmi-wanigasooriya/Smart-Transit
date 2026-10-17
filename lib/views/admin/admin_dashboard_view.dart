import 'package:flutter/material.dart';
import '../sign_in_view.dart';

class AdminDashboardView extends StatefulWidget {
  final String userName;
  final String userEmail;

  const AdminDashboardView({
    super.key,
    this.userName = 'Admin User',
    this.userEmail = 'admin@smarttransit.com',
  });

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  late String _currentName;
  late String _currentEmail;
  
  bool _isMaintenanceMode = false;
  int _selectedTab = 0; // 0: User Management, 1: System Logs

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

  void _handleLogout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInView()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Row(
          children: [
            _buildCleanIcon('🛡️', size: 22, color: Colors.white),
            const SizedBox(width: 10),
            const Text(
              'Advanced Admin Control Center',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1E3A8A),
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
            // Admin Profile Header Banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: _buildCleanIcon('👨‍💻', size: 30),
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
                            color: Colors.red.shade600,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text('Super Administrator', style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Advanced Feature 1: System Maintenance Toggle Control
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: _isMaintenanceMode ? Colors.orange.shade800 : Colors.green.shade700,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('System Maintenance Mode', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text(
                        _isMaintenanceMode ? 'Maintenance Enabled (App Locked)' : 'System Fully Operational',
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Switch(
                    activeColor: Colors.white,
                    activeTrackColor: Colors.orangeAccent,
                    value: _isMaintenanceMode,
                    onChanged: (val) {
                      setState(() {
                        _isMaintenanceMode = val;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(_isMaintenanceMode ? 'System put into maintenance mode.' : 'System restored to normal operation.')),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Advanced Analytics / Key Metrics
            const Text('System Overview & Analytics', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildMetricCard('Total Registered Users', '1,425', '👥', Colors.blue.shade50),
                const SizedBox(width: 12),
                _buildMetricCard('Active Drivers Online', '342', '🚗', Colors.green.shade50),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildMetricCard('Daily Completed Rides', '980', '🛣️', Colors.purple.shade50),
                const SizedBox(width: 12),
                _buildMetricCard('Total Revenue (LKR)', '452,800', '💰', Colors.amber.shade50),
              ],
            ),
            const SizedBox(height: 24),

            // Advanced Feature 2: Tabbed Sections (User Management & Activity Logs)
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedTab == 0 ? const Color(0xFF1E3A8A) : Colors.grey.shade300,
                  ),
                  onPressed: () => setState(() => _selectedTab = 0),
                  child: Text('User Management', style: TextStyle(color: _selectedTab == 0 ? Colors.white : Colors.black87)),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedTab == 1 ? const Color(0xFF1E3A8A) : Colors.grey.shade300,
                  ),
                  onPressed: () => setState(() => _selectedTab = 1),
                  child: Text('System Logs', style: TextStyle(color: _selectedTab == 1 ? Colors.white : Colors.black87)),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
              ),
              child: _selectedTab == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Recent User Registrations', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
                        const Divider(),
                        _buildUserRow(_currentName, _currentEmail, 'Admin', Colors.red),
                        _buildUserRow('Nethmi Hansamali', 'nethmi@gmail.com', 'Passenger', Colors.blue),
                        _buildUserRow('Kasun Perera', 'kasun.driver@transit.com', 'Driver', Colors.green),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Recent Server & Security Logs', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
                        const Divider(),
                        _buildLogItem('[INFO] Database synced successfully at 09:00 AM'),
                        _buildLogItem('[WARNING] High traffic detected on CMB Airport route'),
                        _buildLogItem('[SUCCESS] Driver CAB-4521 completed trip #842'),
                      ],
                    ),
            ),
            const SizedBox(height: 28),

            // Dedicated Logout Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _handleLogout,
                icon: _buildCleanIcon('🚪', size: 20, color: Colors.white),
                label: const Text(
                  'Log Out Admin Account',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String symbol, Color bgColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCleanIcon(symbol, size: 24),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
          ],
        ),
      ),
    );
  }

  Widget _buildUserRow(String name, String email, String role, Color roleColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text(email, style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: roleColor.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
            child: Text(role, style: TextStyle(fontSize: 10, color: roleColor, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildLogItem(String logText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Text(logText, style: const TextStyle(fontSize: 12, fontFamily: 'monospace', color: Colors.black87)),
    );
  }
}