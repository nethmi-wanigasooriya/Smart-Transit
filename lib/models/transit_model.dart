class TransitBooking {
  final String? id;
  final String passengerName;
  final String transportType;
  final String destination;
  final int seats;
  final String time;
  final String price;

  TransitBooking({
    this.id,
    required this.passengerName,
    required this.transportType,
    required this.destination,
    required this.seats,
    required this.time,
    required this.price,
  });

  factory TransitBooking.fromJson(Map<String, dynamic> json) {
    return TransitBooking(
      id: json['id']?.toString(),
      passengerName: json['passenger_name'] ?? '',
      transportType: json['transport_type'] ?? '',
      destination: json['destination'] ?? '',
      seats: json['seats'] ?? 1,
      time: json['time'] ?? '10:15 AM',
      price: json['price'] ?? 'LKR 1500',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'passenger_name': passengerName,
      'transport_type': transportType,
      'destination': destination,
      'seats': seats,
      'time': time,
      'price': price,
    };
  }
}