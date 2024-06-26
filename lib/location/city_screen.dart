import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'location_service.dart';

class CityNameScreen extends StatefulWidget {
  @override
  _CityNameScreenState createState() => _CityNameScreenState();
}

class _CityNameScreenState extends State<CityNameScreen> {
 String? cityName;

  @override
  void initState() {
    super.initState();
    _getCityName();
  }

  Future<void> _getCityName() async {
    Placemark? loc = await LocationService.getCityName(0);
    cityName = loc!.locality;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Location'),
      ),
      body: Center(
        child: cityName != null
            ? Text('City: $cityName')
            : CircularProgressIndicator(),
      ),
    );
  }
}
