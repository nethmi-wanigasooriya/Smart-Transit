import 'package:flutter/material.dart';
import 'my_bookings_view.dart';
import 'live_map_view.dart';
import 'profile_view.dart';
import '../sign_in_view.dart';

class HomeView extends StatefulWidget {
  final String userName;
  final String userEmail;

  const HomeView({
    super.key,
    this.userName = 'Passenger User',
    this.userEmail = 'passenger@smarttransit.com',
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final int _currentIndex = 0;

  final String _fromLocation = 'Katunayake Airport (CMB)';
  final TextEditingController _toDestinationController = TextEditingController(text: 'Colombo Fort');
  DateTime _selectedDate = DateTime.now();

  final List<String> _availableDestinations = [
    'Colombo Fort',
    'Kandy Central',
    'Negombo Town',
    'Galle Fort',
    'Matara Bus Stand',
    'Gampaha Railway Station',
    'Bambalapitiya'
  ];

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

  void _onTabTapped(int index) {
    if (index == _currentIndex) return;

    Widget targetView;
    switch (index) {
      case 0:
        return;
      case 1:
        targetView = const MyBookingsView();
        break;
      case 2:
        targetView = const LiveMapView();
        break;
      case 3:
        targetView = ProfileView(
          userName: widget.userName,
          userEmail: widget.userEmail,
        );
        break;
      default:
        targetView = HomeView(
          userName: widget.userName,
          userEmail: widget.userEmail,
        );
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => targetView,
        transitionDuration: Duration.zero,
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _openMapPicker() {
    String tempSelected = _availableDestinations.first;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            _buildCleanIcon('🗺️', size: 22),
            const SizedBox(width: 10),
            const Text('Select Destination on Map', style: TextStyle(color: Color(0xFF1E3A8A), fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        content: SizedBox(
          width: 350,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCleanIcon('📍', size: 40),
                      const SizedBox(height: 8),
                      const Text('Interactive Map Grid', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
                      const Text('Tap on map markers to choose destination', style: TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: tempSelected,
                decoration: InputDecoration(
                  labelText: 'Detected Location Marker',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                items: _availableDestinations.map((loc) => DropdownMenuItem(value: loc, child: Text(loc))).toList(),
                onChanged: (val) {
                  tempSelected = val!;
                },
              ),
            ],
          ),
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
                _toDestinationController.text = tempSelected;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Destination set to: $tempSelected from Map')),
              );
            },
            child: const Text('Confirm Location', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Row(
          children: [
            _buildCleanIcon('🏠', size: 20, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Welcome, ${widget.userName}',
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
        actions: [
          IconButton(
            icon: _buildCleanIcon('🔔', size: 20, color: Colors.white),
            tooltip: 'Notifications',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications')),
              );
            },
          ),
          IconButton(
            icon: _buildCleanIcon('🚪', size: 20, color: Colors.white),
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
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1E3A8A).withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                children: [
                  _buildCleanIcon('🛫', size: 42, color: Colors.white),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Express Airport Commute', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('Direct airport departures & high-speed rail connection.', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text('Search & Book Transit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(text: _fromLocation),
                    decoration: InputDecoration(
                      labelText: 'From Location (Fixed)',
                      prefixIcon: Center(widthFactor: 1, child: _buildCleanIcon('✈️', size: 18)),
                      suffixIcon: Center(widthFactor: 1, child: _buildCleanIcon('📍', size: 18)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                  ),
                  const SizedBox(height: 14),

                  Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return _availableDestinations.where((String option) {
                        return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (String selection) {
                      _toDestinationController.text = selection;
                    },
                    fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                      if (controller.text.isEmpty && _toDestinationController.text.isNotEmpty) {
                        controller.text = _toDestinationController.text;
                      }
                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        onChanged: (val) {
                          _toDestinationController.text = val;
                        },
                        decoration: InputDecoration(
                          labelText: 'To Destination (Search or Pick from Map)',
                          prefixIcon: Center(widthFactor: 1, child: _buildCleanIcon('🚩', size: 18)),
                          suffixIcon: IconButton(
                            icon: _buildCleanIcon('🗺️', size: 20),
                            tooltip: 'Pick from Map',
                            onPressed: _openMapPicker,
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 14),

                  InkWell(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              _buildCleanIcon('📅', size: 18),
                              const SizedBox(width: 12),
                              Text(
                                '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1E3A8A)),
                              ),
                            ],
                          ),
                          const Text('Change', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Searching transit from $_fromLocation to ${_toDestinationController.text}...')),
                        );
                      },
                      child: const Text('Search Available Rides', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            const Text('Transit Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildServiceCard('Airport Bus', '🚌', 'Highway Express'),
                const SizedBox(width: 12),
                _buildServiceCard('Airport Car', '🚗', 'Private Ride'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildServiceCard('Airport Van', '🚐', 'Group Shuttle'),
                const SizedBox(width: 12),
                _buildServiceCard('Metro Express', '🚆', 'Fast Rail Track'),
              ],
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
          BottomNavigationBarItem(icon: _buildCleanIcon('🏠', size: 20, color: const Color(0xFF1E3A8A)), label: 'Home'),
          BottomNavigationBarItem(icon: _buildCleanIcon('🔖', size: 20, color: Colors.grey), label: 'Bookings'),
          BottomNavigationBarItem(icon: _buildCleanIcon('🗺️', size: 20, color: Colors.grey), label: 'Live Map'),
          BottomNavigationBarItem(icon: _buildCleanIcon('👤', size: 20, color: Colors.grey), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildServiceCard(String title, String iconSymbol, String subtitle) {
    return Expanded(
      child: Container(
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
            _buildCleanIcon(iconSymbol, size: 28),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
            const SizedBox(height: 2),
            Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}