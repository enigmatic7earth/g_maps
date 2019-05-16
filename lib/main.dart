import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(19.0760, 72.8777);
  MapType _currentMapType = MapType.normal;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Maps with Flutter'),
          backgroundColor: Colors.cyan,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              mapType: _currentMapType,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
		    Padding(
		      padding: const EdgeInsets.all(16.0),
		      child: Align(
		        alignment: Alignment.topRight,
		        child: FloatingActionButton(
		          onPressed: _onMapTypeButtonPressed,
		          materialTapTargetSize: MaterialTapTargetSize.padded,
		          backgroundColor: Colors.cyan,
		          child: const Icon(Icons.map, size: 36.0),
		        ),
		      ),
		    ),
		  ],
		),
      ),
    );
  }

void _onMapTypeButtonPressed() {
  setState(() {
    _currentMapType = _currentMapType == MapType.normal
        ? MapType.satellite
        : MapType.normal;
    print(_currentMapType);
  });
}

}