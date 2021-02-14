import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:eye_test/services/Api/apps_services.dart';
import 'package:eye_test/theme/theme.dart';
import 'package:flutter/material.dart';

class InstalledApps extends StatefulWidget {
  @override
  _InstalledAppsState createState() => _InstalledAppsState();
}

class _InstalledAppsState extends State<InstalledApps> {

  final bool _showSystemApps = false;
  bool _onlyLaunchableApps = false;
  bool _usageApps = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ListAppsPagesContent(
          includeSystemApps: _showSystemApps, onlyAppsWithLaunchIntent: _onlyLaunchableApps, usageApps: _usageApps, key: GlobalKey()),
    );
  }
}

class _ListAppsPagesContent extends StatefulWidget {
  final bool includeSystemApps;
  final bool onlyAppsWithLaunchIntent;
  final bool usageApps;

  const _ListAppsPagesContent({Key key, this.includeSystemApps = false, this.onlyAppsWithLaunchIntent = false, this.usageApps = false})
      : super(key: key);

  @override
  __ListAppsPagesContentState createState() => __ListAppsPagesContentState();
}

class __ListAppsPagesContentState extends State<_ListAppsPagesContent> {
  List<AppUsageInfo> _infos = [];

  void getUsageStats() async {
    final _appsServices = AppsServices();
    try {
      var endDate = DateTime.now();
      var startDate = endDate.subtract(Duration(hours: 1));
      var infoList = await AppUsage.getAppUsage(startDate, endDate);

      setState(() {
        _infos = infoList;
        _appsServices.createApps({'apps': _infos});
        print('List of Apps');
        print(_infos);
      });
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Application>>(
        future: DeviceApps.getInstalledApplications(
            includeAppIcons: true,
            includeSystemApps: widget.includeSystemApps,
            onlyAppsWithLaunchIntent: widget.onlyAppsWithLaunchIntent,
            usageApps: widget.usageApps),
        builder: (BuildContext context, AsyncSnapshot<List<Application>> data) {
          if (data.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            var apps = data.data;
            print(apps);
            return Scrollbar(
              child: ListView.builder(
                  itemBuilder: (BuildContext context, int position) {
                    var app = apps[position];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: <BoxShadow>[
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
                              child: app is ApplicationWithIcon
                                  ? Image.memory(
                                app.icon,
                              )
                                  : null,
                            ),
                          ),
                          title: Text(app.appName, style: TextStyles.title.bold),
                          subtitle: Text('Version: ${app.versionName}\n'),
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

