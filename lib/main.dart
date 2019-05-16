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
  // Code added
  // Adding mapType
  MapType _currentMapType = MapType.normal;
  // Marker
  final Set<Marker> _markers = {};

  // Tracking current location
  LatLng _lastMapPosition = _center;

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
              mapType: _currentMapType, // Map type
              markers: _markers, // markers
              onCameraMove: _onCameraMove, // Moves camera
              myLocationEnabled: true, // shows user location
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              tiltGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
		    Padding(
		      padding: const EdgeInsets.all(10.0),
		      child: Align(
		        alignment: Alignment.topRight,
		        child: Column(
		          children: <Widget>[
		            FloatingActionButton(
		              onPressed: _onMapTypeButtonPressed,
		              materialTapTargetSize: MaterialTapTargetSize.padded,
		              backgroundColor: Colors.cyan,
		              child: const Icon(Icons.map, size: 36.0),
		            ),
		            SizedBox(height: 16.0),
                    FloatingActionButton(
                      onPressed: _onAddMarkerButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.cyan,
                      child: const Icon(Icons.add_location, size: 36.0),
                    ),
                    SizedBox(height: 16.0),
                    FloatingActionButton(
                      onPressed: _gotoGoogleHQ,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.cyan,
                      child: const Icon(Icons.flight, size: 36.0),
                    ),
		          ], 
		         ),
		       ),
		    ),
		  ],
		),
      ),
    );
  }

	void _onCameraMove(CameraPosition position) {
	  _lastMapPosition = position.target;
	}

	void _gotoGoogleHQ(){


	  // Mark Googleplex
	  LatLng _googleHQ = LatLng(37.4219999, -122.0862462);
	  
	  setState(() {
	    _markers.add(Marker(
	      // This marker id can be anything that uniquely identifies each marker.
	      markerId: MarkerId(_lastMapPosition.toString()),
	      position: _googleHQ,
	      infoWindow: InfoWindow(
	        title: 'Googleplex',
	        snippet: 'Google HQ',
	      ),
	      icon: BitmapDescriptor.fromAsset('assets/images/g_placeholder.png',),
	    ));
	  });




	}


	void _onMapTypeButtonPressed() {
	  setState(() {
	    _currentMapType = _currentMapType == MapType.normal
	        ? MapType.satellite
	        : MapType.normal;
	    print(_currentMapType);
	  });
	}
	void _onAddMarkerButtonPressed() {
	  setState(() {
	    _markers.add(Marker(
	      // This marker id can be anything that uniquely identifies each marker.
	      markerId: MarkerId(_lastMapPosition.toString()),
	      position: _lastMapPosition,
	      infoWindow: InfoWindow(
	        title: 'Really cool place',
	        snippet: '5 Star Rating',
	      ),
	      icon: BitmapDescriptor.defaultMarker,
	    ));
	  });
	}

}