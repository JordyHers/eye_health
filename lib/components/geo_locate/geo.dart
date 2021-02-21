import 'dart:async';

import 'package:eye_test/services/Geo_locator/geo_locator_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Geo extends StatefulWidget {
  final Position initialPosition;

  Geo(this.initialPosition);

  @override
  State<StatefulWidget> createState() => _GeoState();
}

class _GeoState extends State<Geo> {
  final GeoLocatorService geoService = GeoLocatorService();
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    geoService.getCurrentLocation().listen((position) {
      centerScreen(position);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 250,
      child: Center(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(widget.initialPosition.latitude,
                    widget.initialPosition.longitude),
                zoom: 10),
            mapType: MapType.normal,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
      ),
    );
  }

  Future<void> centerScreen(Position position) async {
    final controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 12.0)));
  }
}

//
//
//
//
// Column(
// children: apps.map((x) {
// return app is ApplicationWithIcon ? _appsTile(x) : null;
// }).toList());
// // ListTile(
// //   leading: app is ApplicationWithIcon
// //       ? CircleAvatar(
// //     backgroundImage: MemoryImage(app.icon),
// //     backgroundColor: Colors.white,
// //   )
// //       : null,
// //   onTap: () => DeviceApps.openApp(app.packageName),
// //   title: Text('${app.appName} (${app.packageName})'),
// //   subtitle: Text('Version: ${app.versionName}\n'
// //       'System app: ${app.systemApp}\n'
// //       'APK file path: ${app.apkFilePath}\n'
// //       'Data dir: ${app.dataDir}\n'
// //       'Installed: ${DateTime.fromMillisecondsSinceEpoch(app.installTimeMillis).toString()}\n'
// //       'Updated: ${DateTime.fromMillisecondsSinceEpoch(app.updateTimeMillis).toString()}'),
// // ),
