import 'package:flutter/material.dart';
import 'home_view.dart';
import 'live_map_view.dart';
import 'profile_view.dart';
import '../sign_in_view.dart';

class MyBookingsView extends StatefulWidget {
  const MyBookingsView({super.key});

  @override
  State<MyBookingsView> createState() => _MyBookingsViewState();
}

class _MyBookingsViewState extends State<MyBookingsView> {
  int _currentIndex = 1; // My Bookings Tab Selected

  // Sample list of bookings with mutable status
  final List<Map<String, dynamic>> _bookings = [
    {
      'id': 'BK-1024',
      'title': 'Airport Express Bus EX1',
      'route': 'Colombo Fort ➡️ Katunayake Airport',
      'seat': 'Seat: 14B',
      'time': '10:30 AM Today',
      'status': 'CONFIRMED',
      'color': Colors.green,
      'qrCode': 'SMART-TRANSIT-EX1-1024'
    },
    {
      'id': 'BK-1025',
      'title': 'Metro Line M1 Express',
      'route': 'Fort Railway ➡️ CMB Airport Terminal',
      'seat': 'Seat: 08A',
      'time': '02:15 PM Tomorrow',
      'status': 'UPCOMING',
      'color': Colors.blue,
      'qrCode': 'SMART-TRANSIT-M1-1025'
    },
    {
      'id': 'BK-1010',
      'title': 'Katunayake Airport Shuttle',
      'route': 'Negombo ➡️ Airport Gate 2',
      'seat': 'Seat: 02C',
      'time': 'Yesterday',
      'status': 'COMPLETED',
      'color': Colors.grey,
      'qrCode': 'SMART-TRANSIT-SHUTTLE-1010'
    },
  ];

  void _onTabTapped(int index) {
    if (index == _currentIndex) return;

    Widget targetView;
    switch (index) {
      case 0:
        targetView = const HomeView();
        break;
      case 1:
        return;
      case 2:
        targetView = const LiveMapView();
        break;
      case 3:
        targetView = const ProfileView();
        break;
      default:
        targetView = const HomeView();
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => targetView,
        transitionDuration: Duration.zero,
      ),
    );
  }

  // Advanced Feature: Show Digital QR Ticket Modal Dialog
  void _showTicketQRCode(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Text('🎫', style: TextStyle(fontSize: 24)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                booking['id'],
                style: const TextStyle(color: Color(0xFF0F2C59), fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(booking['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 4),
            Text(booking['route'], style: const TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            
            // Simulated QR Code Container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F7FC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  const Text('⬛ 🔲 ⬛ 🔲 ⬛', style: TextStyle(fontSize: 28, letterSpacing: 4)),
                  const Text('🔲 ⬛ 🔲 ⬛ 🔲', style: TextStyle(fontSize: 28, letterSpacing: 4)),
                  const Text('⬛ 🔲 ⬛ 🔲 ⬛', style: TextStyle(fontSize: 28, letterSpacing: 4)),
                  const SizedBox(height: 10),
                  Text(
                    booking['qrCode'],
                    style: const TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: Color(0xFF0F2C59)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Text('${booking['seat']} • ${booking['time']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text(
              'Scan this QR code at the airport transit terminal gate scanner.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Color(0xFF0F2C59), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // Advanced Feature: Cancel Booking Action
  void _cancelBooking(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Cancel Booking', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to cancel this transit booking? Refund will be processed in 24 hours.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                _bookings[index]['status'] = 'CANCELLED';
                _bookings[index]['color'] = Colors.red;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Booking Cancelled Successfully!')),
              );
            },
            child: const Text('Yes, Cancel', style: TextStyle(color: Colors.white)),
          ),
        ],
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
            Text('🎫', style: TextStyle(fontSize: 22)),
            SizedBox(width: 10),
            Text(
              'My Bookings & QR Tickets',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF0F2C59),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Text('🚪', style: TextStyle(fontSize: 20)),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SignInView()),
                (route) => false,
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0F2C59),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Text('📱', style: TextStyle(fontSize: 32)),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Digital QR Boarding Passes', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(height: 2),
                        Text('Tap any ticket to view its QR code for airport security & gate scanners.', style: TextStyle(color: Colors.white70, fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            const Text('All Transit Bookings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F2C59))),
            const SizedBox(height: 12),

            // ListView of Bookings with Advanced Actions
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _bookings.length,
              itemBuilder: (context, index) {
                final booking = _bookings[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(booking['id'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
                          Text(booking['status'], style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: booking['color'])),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(booking['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0F2C59))),
                      const SizedBox(height: 2),
                      Text(booking['route'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      const SizedBox(height: 6),
                      Text('${booking['seat']} • ${booking['time']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.blueGrey)),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (booking['status'] != 'CANCELLED' && booking['status'] != 'COMPLETED')
                            TextButton.icon(
                              onPressed: () => _cancelBooking(index),
                              icon: const Text('❌', style: TextStyle(fontSize: 14)),
                              label: const Text('Cancel', style: TextStyle(color: Colors.red, fontSize: 12)),
                            ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0F2C59),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () => _showTicketQRCode(booking),
                            icon: const Text('🔲', style: TextStyle(fontSize: 14)),
                            label: const Text('View QR Code', style: TextStyle(color: Colors.white, fontSize: 12)),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF0F2C59),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Text('🏠', style: TextStyle(fontSize: 20)), label: 'Home'),
          BottomNavigationBarItem(icon: Text('🎫', style: TextStyle(fontSize: 20)), label: 'Bookings'),
          BottomNavigationBarItem(icon: Text('🗺️', style: TextStyle(fontSize: 20)), label: 'Live Map'),
          BottomNavigationBarItem(icon: Text('👤', style: TextStyle(fontSize: 20)), label: 'Profile'),
        ],
      ),
    );
  }
}