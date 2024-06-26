import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Placemark?> getCityName(int nearby) async {
    // Check if location service is enabled
    if (!await Geolocator.isLocationServiceEnabled()) {
      print("Location services are disabled.");
      return null;
    }

    // Request location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        print("Location permissions are permanently denied.");
        return null;
      }
    }

    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      print("Location permissions are denied.");
      return null;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      // Get the first placemark (usually the most relevant)
      Placemark placemark = placemarks[nearby];

      // Extract the city name
      //String city = placemark. ?? "";
      return placemark;
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }
}
