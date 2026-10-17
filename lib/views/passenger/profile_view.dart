import 'package:flutter/material.dart';
import 'home_view.dart';
import 'my_bookings_view.dart';
import 'live_map_view.dart';
import '../sign_in_view.dart';

class ProfileView extends StatefulWidget {
  final String userName;
  final String userEmail;

  const ProfileView({
    super.key,
    this.userName = 'Passenger User',
    this.userEmail = 'passenger@smarttransit.com',
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final int _currentIndex = 3;

  late String _currentName;
  late String _currentEmail;
  String _phoneNumber = '+94 77 123 4567';
  double _walletBalance = 4250.00;

  bool _isDarkMode = false;
  bool _pushNotifications = true;
  bool _locationSharing = true;

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
  void didUpdateWidget(covariant ProfileView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.userName != widget.userName || oldWidget.userEmail != widget.userEmail) {
      setState(() {
        _currentName = widget.userName;
        _currentEmail = widget.userEmail;
      });
    }
  }

  void _onTabTapped(int index) {
    if (index == _currentIndex) return;

    Widget targetView;
    switch (index) {
      case 0:
        targetView = HomeView(userName: _currentName, userEmail: _currentEmail);
        break;
      case 1:
        targetView = const MyBookingsView();
        break;
      case 2:
        targetView = const LiveMapView();
        break;
      case 3:
        return;
      default:
        targetView = HomeView(userName: _currentName, userEmail: _currentEmail);
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => targetView,
        transitionDuration: Duration.zero,
      ),
    );
  }

  void _openEditProfileDialog() {
    final nameEditController = TextEditingController(text: _currentName);
    final phoneEditController = TextEditingController(text: _phoneNumber);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            _buildCleanIcon('✏️', size: 20),
            const SizedBox(width: 8),
            const Text('Edit Profile Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameEditController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Center(widthFactor: 1, child: _buildCleanIcon('👤', size: 18)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: phoneEditController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Center(widthFactor: 1, child: _buildCleanIcon('📞', size: 18)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E3A8A)),
            onPressed: () {
              setState(() {
                _currentName = nameEditController.text.trim();
                _phoneNumber = phoneEditController.text.trim();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully!')),
              );
            },
            child: const Text('Save Changes', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _openTopUpDialog() {
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            _buildCleanIcon('💳', size: 20),
            const SizedBox(width: 8),
            const Text('Top Up Wallet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter amount to add to your transit balance:', style: TextStyle(fontSize: 13, color: Colors.grey)),
            const SizedBox(height: 12),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount (LKR)',
                prefixIcon: Center(widthFactor: 1, child: _buildCleanIcon('💵', size: 18)),
                hintText: 'e.g. 1000',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
            onPressed: () {
              double? amount = double.tryParse(amountController.text.trim());
              if (amount != null && amount > 0) {
                setState(() {
                  _walletBalance += amount;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Successfully added LKR ${amount.toStringAsFixed(2)} to your wallet!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a valid amount!')),
                );
              }
            },
            child: const Text('Proceed Top Up', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
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
    final backgroundColor = _isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8FAFC);
    final cardColor = _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = _isDarkMode ? Colors.white : const Color(0xFF1E3A8A);
    final subTextColor = _isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Passenger Profile',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(_isDarkMode ? 0.3 : 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: const Color(0xFF1E3A8A),
                    child: _buildCleanIcon('👤', size: 34, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentName,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _currentEmail,
                          style: TextStyle(fontSize: 12, color: subTextColor),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _phoneNumber,
                          style: TextStyle(fontSize: 12, color: subTextColor),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text('Verified Passenger', style: TextStyle(fontSize: 10, color: Colors.blue, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: _buildCleanIcon('✏️', size: 20, color: Colors.blueAccent),
                    onPressed: _openEditProfileDialog,
                    tooltip: 'Edit Profile',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Transit Wallet Balance', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text('LKR ${_walletBalance.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _openTopUpDialog,
                    icon: _buildCleanIcon('💳', size: 16, color: Colors.white),
                    label: const Text('Top Up', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text('App Preferences', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    activeColor: const Color(0xFF1E3A8A),
                    title: Text('Dark Mode', style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: Text('Switch app theme mode', style: TextStyle(color: subTextColor, fontSize: 11)),
                    secondary: _buildCleanIcon('🌙', size: 20),
                    value: _isDarkMode,
                    onChanged: (val) => setState(() => _isDarkMode = val),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    activeColor: const Color(0xFF1E3A8A),
                    title: Text('Push Notifications', style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: Text('Receive booking status & alerts', style: TextStyle(color: subTextColor, fontSize: 11)),
                    secondary: _buildCleanIcon('🔔', size: 20),
                    value: _pushNotifications,
                    onChanged: (val) => setState(() => _pushNotifications = val),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    activeColor: const Color(0xFF1E3A8A),
                    title: Text('Location Tracking', style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: Text('Enable GPS for live route updates', style: TextStyle(color: subTextColor, fontSize: 11)),
                    secondary: _buildCleanIcon('📍', size: 20),
                    value: _locationSharing,
                    onChanged: (val) => setState(() => _locationSharing = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: _handleLogout,
                icon: _buildCleanIcon('🚪', size: 20, color: Colors.white),
                label: const Text(
                  'Log Out from Account',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF1E3A8A),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(icon: _buildCleanIcon('🏠', size: 20, color: Colors.grey), label: 'Home'),
          BottomNavigationBarItem(icon: _buildCleanIcon('🔖', size: 20, color: Colors.grey), label: 'Bookings'),
          BottomNavigationBarItem(icon: _buildCleanIcon('🗺️', size: 20, color: Colors.grey), label: 'Live Map'),
          BottomNavigationBarItem(icon: _buildCleanIcon('👤', size: 20, color: const Color(0xFF1E3A8A)), label: 'Profile'),
        ],
      ),
    );
  }
}