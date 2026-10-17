import 'package:flutter/material.dart';
import 'home_view.dart';
import 'my_bookings_view.dart';
import 'profile_view.dart';
import '../sign_in_view.dart';

class LiveMapView extends StatefulWidget {
  const LiveMapView({super.key});

  @override
  State<LiveMapView> createState() => _LiveMapViewState();
}

class _LiveMapViewState extends State<LiveMapView> {
  int _currentIndex = 2; // Live Map Tab Selected
  String _selectedRoute = 'Airport Express Bus (EX1)';
  
  // Advanced Simulation Data based on selected route
  final Map<String, Map<String, dynamic>> _routeDetails = {
    'Airport Express Bus (EX1)': {
      'busNo': 'EX-084-LK',
      'nextStop': 'Katunayake Airport Terminal Gate 2',
      'eta': '12 Mins',
      'speed': '65 km/h',
      'capacity': 'Normal (60% Full)',
      'driver': 'Mr. Perera (+94 77 123 4567)',
      'stops': ['Colombo Fort', 'Peliyagoda Expressway', 'Ja-Ela Interchange', 'Katunayake Airport']
    },
    'Metro Rail Line 1 (Fort - Airport)': {
      'busNo': 'METRO-TRAIN-02',
      'nextStop': 'Seeduwa Railway Station',
      'eta': '7 Mins',
      'speed': '85 km/h',
      'capacity': 'Crowded (85% Full)',
      'driver': 'Driver Station Control #4',
      'stops': ['Colombo Fort', 'Maradana', 'Ragama', 'Seeduwa', 'Airport Junction']
    },
    'Colombo Express Shuttle': {
      'busNo': 'SHUTTLE-EX-9',
      'nextStop': 'Katunayake Arrival Lounge',
      'eta': '19 Mins',
      'speed': '50 km/h',
      'capacity': 'Available Seats (30% Full)',
      'driver': 'Mr. Silva (+94 71 987 6543)',
      'stops': ['Bambalapitiya', 'Colombo Fort', 'Katunayake Airport']
    }
  };

  void _onTabTapped(int index) {
    if (index == _currentIndex) return;

    Widget targetView;
    switch (index) {
      case 0:
        targetView = const HomeView();
        break;
      case 1:
        targetView = const MyBookingsView();
        break;
      case 2:
        return;
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

  // Advanced Feature: Show Full Route Stops Dialog
  void _showRouteStopsDialog() {
    final currentRouteData = _routeDetails[_selectedRoute]!;
    final List<String> stops = currentRouteData['stops'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Text('🗺️', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                _selectedRoute,
                style: const TextStyle(color: Color(0xFF0F2C59), fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: stops.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF0F2C59),
                  child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontSize: 12)),
                ),
                title: Text(stops[index], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: Text(index == 0 ? 'Departure Origin' : (index == stops.length - 1 ? 'Destination Terminal' : 'Transit Stop'), style: const TextStyle(fontSize: 11, color: Colors.grey)),
              );
            },
          ),
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

  @override
  Widget build(BuildContext context) {
    final routeInfo = _routeDetails[_selectedRoute]!;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        title: const Row(
          children: [
            Text('🗺️', style: TextStyle(fontSize: 22)),
            SizedBox(width: 10),
            Text(
              'Live Transit Map & GPS',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF0F2C59),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Text('🔄', style: TextStyle(fontSize: 18)),
            tooltip: 'Refresh GPS',
            onPressed: () {
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('GPS Coordinates Refreshed Successfully!')),
              );
            },
          ),
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
      body: Stack(
        children: [
          // Simulated Interactive Map Canvas View
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFE5ECF4),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 90, bottom: 20, left: 16, right: 16),
                child: Column(
                  children: [
                    // Main GPS Status Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text('📡', style: TextStyle(fontSize: 45)),
                          const SizedBox(height: 10),
                          const Text(
                            'Real-Time Fleet Tracking Active',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F2C59),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Vehicle ID: ${routeInfo['busNo']}',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.blue),
                          ),
                          const SizedBox(height: 16),

                          // Next Stop & ETA Box
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                const Text('🚍', style: TextStyle(fontSize: 28)),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Next Stop: ${routeInfo['nextStop']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0F2C59))),
                                      const SizedBox(height: 3),
                                      Text('ETA: ${routeInfo['eta']} • Speed: ${routeInfo['speed']}', style: const TextStyle(fontSize: 11, color: Colors.blueGrey, fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Advanced Stats Grid
                          Row(
                            children: [
                              _buildMiniStatCard('Capacity', routeInfo['capacity'], '👥'),
                              const SizedBox(width: 10),
                              _buildMiniStatCard('Driver Info', routeInfo['driver'], '👨‍✈️'),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // View Route Stops Button
                          SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0F2C59),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: _showRouteStopsDialog,
                              icon: const Text('📍', style: TextStyle(fontSize: 16)),
                              label: const Text('View All Route Stops', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Top Floating Route Selection Bar
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedRoute,
                  isExpanded: true,
                  icon: const Text('🔻'),
                  items: _routeDetails.keys.map((String routeName) {
                    return DropdownMenuItem<String>(
                      value: routeName,
                      child: Text(
                        routeName,
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F2C59), fontSize: 13),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedRoute = newValue!;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
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

  Widget _buildMiniStatCard(String title, String value, String emoji) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F7FC),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 6),
                Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F2C59)), overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}