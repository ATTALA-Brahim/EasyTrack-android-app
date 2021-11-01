import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../providers/locations.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);
  static const routeName = '/map';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var _isLoading = false;

   

  @override
  void initState() {
    
    Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => setState(() {
              Provider.of<Locations>(context, listen: false).fetchLocations();
            }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final locations = Provider.of<Locations>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        leading: BackButton(
        color: Colors.white,
        onPressed : () => Navigator.pop(context)
 ), 
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : locations.points == null
                  ? Center(
                    child:Text('No locations'))
          : FlutterMap(
              options: MapOptions(
                center: LatLng(35.2, -0.65),
                zoom: 13.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/abdo12198/cktluilr622w417o3ersqhxt2/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYWJkbzEyMTk4IiwiYSI6ImNrcHNlNndzZjBvNXYyb3FrcW5mZjQzdmoifQ.ER0FoeaneKzPrz485SgLSQ",
                  additionalOptions: {
                    'accesToken':
                        'pk.eyJ1IjoiYWJkbzEyMTk4IiwiYSI6ImNrcHNlNndzZjBvNXYyb3FrcW5mZjQzdmoifQ.ER0FoeaneKzPrz485SgLSQ',
                    'id': 'mapbox.mapbox-streets-v8',
                  },
                  attributionBuilder: (_) {
                    return Text("© OpenStreetMap contributors");
                  },
                ),
                MarkerLayerOptions(
                  markers: locations.markers,
                ),
                PolylineLayerOptions(
                  polylines: [
                  Polyline(
                    points: locations.points!,
                    color: Colors.green,
                    borderColor: Colors.green,
                    strokeWidth: 5.0,

                    ),
                ],
                
                
                )
              ],
            ),
    );
  }
}
