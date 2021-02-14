
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Geo extends StatefulWidget {
  @override
  _GeoState createState() => _GeoState();
}

class _GeoState extends State<Geo> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(),
    );
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
