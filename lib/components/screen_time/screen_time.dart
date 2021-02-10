import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eye_test/screens/profile_page/profile_page_constants.dart';
import 'package:eye_test/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ScreenTime extends StatefulWidget {
  @override
  _ScreenTimeState createState() => _ScreenTimeState();
}

class _ScreenTimeState extends State < ScreenTime > {


  //   @override
  //   Widget build(BuildContext context) {
  //     return  Scaffold(
  //         appBar: AppBar(
  //           title: const Text('App Usage Example'),
  //           backgroundColor: Colors.green,
  //         ),
  //         body:
  //         floatingActionButton: FloatingActionButton(
  //             onPressed: getUsageStats, child: Icon(Icons.file_download)),
  //       );
  //
  //   }
  // }

  bool _showSystemApps = false;
  bool _onlyLaunchableApps = false;
  bool _usageApps = false;

  Widget _appBar() {
    return AppBar(
      title: Text('installed apps'.tr().toString(), style: TextStyles.h2Style, ),
      elevation: 0,
      backgroundColor: kAppPrimaryColor,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          size: 30,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: < Widget > [

        PopupMenuButton < String > (
          icon: Icon(Icons.more_vert, color: Colors.black, ),

          itemBuilder: (BuildContext context) {
            return <PopupMenuItem < String >> [
              PopupMenuItem < String > (
                value: 'system_apps', child: Text('toggle system apps'.tr())),
              PopupMenuItem < String > (
                value: 'launchable_apps',
                child: Text('toggle launchable apps only'.tr(), ),
              ), PopupMenuItem < String > (
                value: 'usage_apps',
                child: Text('usage_apps'.tr(), ),
              )
            ];
          },
          onSelected: (String key) {
            if (key == 'system_apps') {
              setState(() {
                _showSystemApps = !_showSystemApps;
              });
            }
            if (key == 'launchable_apps') {
              setState(() {
                _onlyLaunchableApps = !_onlyLaunchableApps;
              });
            }
            if (key == 'usage_apps') {
              setState(() {
                _usageApps = !_usageApps;

              });
            }
          },
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _ListAppsPagesContent(
        includeSystemApps: _showSystemApps,
        onlyAppsWithLaunchIntent: _onlyLaunchableApps,
        usageApps: _usageApps,
        key: GlobalKey()),
    );
  }
}

class _ListAppsPagesContent extends StatefulWidget {

  final bool includeSystemApps;
  final bool onlyAppsWithLaunchIntent;
  final bool usageApps;

  const _ListAppsPagesContent({
    Key key,
    this.includeSystemApps = false,
    this.onlyAppsWithLaunchIntent = false,
    this.usageApps = false
  }): super(key: key);

  @override
  __ListAppsPagesContentState createState() => __ListAppsPagesContentState();
}

class __ListAppsPagesContentState extends State < _ListAppsPagesContent > {
  List < AppUsageInfo > _infos = [];
  int _sumHours = 0;
  int _sumMin = 0;

  @override
  void initState() {
    super.initState();
  }


  void getUsageStats() async {
    try {
      var endDate = DateTime.now();
      var startDate = endDate.subtract(Duration(hours: 1));
      var infoList = await AppUsage.getAppUsage(startDate, endDate);
      setState(() {
        _infos = infoList;
        print('List of Apps');
        print(_infos);
      });
    }
    on AppUsageException
    catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder < List < Application >> (
      future: DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: widget.includeSystemApps,
        onlyAppsWithLaunchIntent: widget.onlyAppsWithLaunchIntent,
        usageApps: widget.usageApps),
      builder: (BuildContext context, AsyncSnapshot < List < Application >> data) {
        if (widget.usageApps) {
          getUsageStats(); 
          return ListView.builder(
            itemCount: _infos.length,
            itemBuilder: (context, index) {
              for (var i = 0; _infos.length > i; i++) {
                _sumHours += _infos[index].usage.inHours;
                _sumMin += _infos[index].usage.inMinutes;
              }
              print('Sum of the hours');
              print(_sumHours);
              print('Sum of the minutes');
              print(_sumMin);

              return ListTile(
                title: Text(_infos[index].appName),
                trailing: Text(_infos[index].usage.toString()));
            });

        }
        if (data.data == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          var apps = data.data;
          print(apps);
          return
          Scrollbar(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int position) {
                var app = apps[position];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: < BoxShadow > [
                      BoxShadow(
                        offset: Offset(4, 4),
                        blurRadius: 10,
                        color: LightColor.grey.withOpacity(.2),
                      ),
                      BoxShadow(
                        offset: Offset(-3, 0),
                        blurRadius: 15,
                        color: LightColor.grey.withOpacity(.1),
                      )
                    ],
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.transparent,
                          ),
                          child: app is ApplicationWithIcon ? Image.memory(
                            app.icon,
                          ) : null,
                        ),
                      ),
                      title: Text(app.appName, style: TextStyles.title.bold),
                      subtitle: Text('Version: ${app.versionName}\n'
                        'Installed: ${DateTime.fromMillisecondsSinceEpoch(app.installTimeMillis).toString()}\n'
                        'Updated: ${DateTime.fromMillisecondsSinceEpoch(app.updateTimeMillis).toString()}'
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ).ripple(() {
                    DeviceApps.openApp(app.packageName);
                  }, borderRadius: BorderRadius.all(Radius.circular(20))),
                );
              },
              itemCount: apps.length),
          );
        }
      });
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