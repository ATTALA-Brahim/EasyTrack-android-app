import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latlong2/latlong.dart';

class Locations with ChangeNotifier {
  List<Marker> _markers = [];

  List<Marker> get markers {
    return [..._markers];
  }

  List<LatLng> ? _points = [];

  List<LatLng> ? get points {
    return [..._points!];
  }

  Future<void> fetchLocations() async {
    final List<Marker> loadedmarkers = [];
    final List<LatLng> loadedpoints = [];
    final url = Uri.parse(
        'https://gpsss-94c2e-default-rtdb.europe-west1.firebasedatabase.app/location.json');
    try {
      final response = await http.get(url);
      final extractedmarkers =
          json.decode(response.body) as Map<String, dynamic>;
      

      extractedmarkers.forEach((markerId, markerdata) {
        loadedmarkers.add(Marker(
          builder: (ctx) => Container(
            child: Icon(Icons.add_location_rounded , color: Colors.red, size: 35.0,),
          ),
          point: LatLng(markerdata['latitude'].toDouble(), markerdata['longtitude'].toDouble()),
        ));
        loadedpoints
            .add(LatLng(markerdata['latitude'].toDouble(), markerdata['longtitude'].toDouble()));
      });
      _markers = loadedmarkers;
      _points = loadedpoints;
      print(extractedmarkers);
      print(_markers.length);
      print(_points!.length);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
