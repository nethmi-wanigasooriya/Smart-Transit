class ApiConfig {

  static const String baseUrl = 'https://7b003a5c-ca96-409d-a0ac-9c9cda66539c-dev.e1-us-east-azure.choreoapis.dev/smart-transit-new/smart-transit-backend/v1.0';
  
  static const String signInEndpoint = '$baseUrl/auth/signin';
  static const String signUpEndpoint = '$baseUrl/auth/signup';
  static const String driverTripsEndpoint = '$baseUrl/driver/trips';
}