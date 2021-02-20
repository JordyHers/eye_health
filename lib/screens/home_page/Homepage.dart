import 'package:app_usage/app_usage.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_apps/device_apps.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eye_test/models/apps_model.dart';
import 'package:eye_test/models/bar_charts_model.dart';
import 'package:eye_test/repository/data_repository.dart';
import 'package:eye_test/services/Api/Auths.dart';
import 'package:eye_test/services/Internet_Connection/bloc.dart';
import 'package:eye_test/services/Internet_Connection/network_bloc.dart';

//_++++++++++++++++++++++++++++++   MY IMPORTS ++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
import 'package:eye_test/theme/theme.dart';
import 'package:eye_test/widgets/bar_charts_graph.dart';
import 'package:eye_test/widgets/horizontal_ListView.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final picker = ImagePicker();
  List<DocumentSnapshot> Apps = <DocumentSnapshot>[];
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final Status _status = Status.Uninitialized;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Status get status => _status;

  TabController _tabController;
  List<AppUsageInfo> _infos = [];
  final DataRepository _rep = DataRepository();
  String _token;

  void getUsageStats() async {
    final userProvider = Provider.of<Auths>(context, listen: false);

    try {
      var endDate = DateTime.now();
      var startDate = endDate.subtract(Duration(hours: 1));
      var infoList = await AppUsage.getAppUsage(startDate, endDate);
      await _firebaseMessaging.getToken().then((token) {
        _token = token;
        print('Device Token: $_token');
      });
      setState(() {
        _infos = infoList;
        Future.delayed(Duration.zero, () {
          _rep.updateMod(userProvider.currentUser, _infos, _token);
        });
      });
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void initState() {
    super.initState();
    // appsDataList = appsMapList.map((k) => AppsModel.fromJson(k)).toList();
    final userProvider = Provider.of<Auths>(context, listen: false);
    userProvider.reloadUserModel();
    Future.delayed(Duration.zero, () {
      getUsageStats();
    });
    if (userProvider.currentUser != null) {
    } else {}
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.notifications,
          size: 30,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            size: 30,
            color: LightColor.grey,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/search_algolia');
          },
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/profile_page');
          },
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              // height: 40,
              // width: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
              ),
              child: Hero(
                tag: 'profile',
                child: Icon(
                  Icons.settings,
                  color: LightColor.grey,
                  size: 25,
                ),
              ),
            ),
          ).p(8),
        ),
      ],
    );
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child:
              Text('2 Hours 30 mins'.tr().toString(), style: TextStyles.titleM),
        ),
        Text('16 mins more than the previous day'.tr().toString(),
            style: TextStyles.bodySm.subTitleColor),
      ],
    ).p16;
  }

  Widget _category() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('category'.tr().toString(), style: TextStyles.titleNormal),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          width: AppTheme.fullWidth(context),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              SizedBox(height: 20,width: 20,),
              _categoryCardFocus(
                  'focus mode'.tr().toString(), 'concentrate'.tr().toString(),
                  color: LightColor.purple, lightColor: LightColor.purpleLight),
              SizedBox(height: 20,width: 20,),
              _categoryCardFindOnMap('Find on Map'.tr().toString(),
                  color: LightColor.skyBlue, lightColor: LightColor.lightBlue),
            ],
          ),
        ),
      ],
    );
  }

  ///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ///++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ///_______________________-WIDGET FOCUS MODE _________________________________________________________

  Widget _categoryCardFocus(String title, String subtitle,
      {Color color, Color lightColor}) {
    var titleStyle = TextStyles.title.bold.white;
    var subtitleStyle = TextStyles.body.bold.white;
    // if (AppTheme.fullWidth(context) < 392) {
    //   titleStyle = TextStyles.body.bold.white;
    //   subtitleStyle = TextStyles.bodySm.bold.white;
    // }
    return Container(
      height: 40,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Meditation-rafiki.png'),
          fit: BoxFit.contain,
        ),
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20)),

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: Text(
              subtitle,
              style: TextStyles.titleNormal,
            ).hP8,
          ),
        ],
      ).p16.ripple(() {
        Navigator.pushNamed(context, '/focus_mode');
      }, borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }

  ///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ///++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ///_______________________-WIDGET SCREEN TIME _________________________________________________________
  Widget _categoryCardFindOnMap(String subtitle,
      {Color color, Color lightColor}) {
    var subtitleStyle = TextStyles.body.bold.black;
    // if (AppTheme.fullWidth(context) < 392) {
    //   subtitleStyle = TextStyles.bodySm.bold.grey;
    // }
    return Container(
      height: 40,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Navigation-pana.png'),
          fit: BoxFit.contain,
        ),
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20)),

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: Text(
              subtitle,
              style: TextStyles.titleNormal,
            ).hP8,
          ),
        ],
      ).p16.ripple(() {
        Navigator.pushNamed(context, '/geo');
      }, borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }

  double getRandom() {
    var list = [0.1, 0.3, 0.7, 0.4, 0.6, 0.9, 0.65, 0.85];
    var rn = (list..shuffle()).first;
    return rn;
  }

  // Widget getMostUsedApps() {
  //   return Column(
  //       children: appsDataList.map((x) {
  //     return _appsTile(x);
  //   }).toList());
  // }

  Widget appsTile(AppsModel model) {
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
              child: Image.asset(
                model.image,
                height: 15,
                width: 30,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text(model.name, style: TextStyles.title.bold),
          subtitle: Text(
            model.usage,
            style: TextStyles.bodySm.subTitleColor.bold,
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ).ripple(() {
        //Navigator.pushNamed(context, "/DetailPage", arguments: model);
      }, borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }

  final List<BarChartModel> data = [
    BarChartModel(
      days: 'Mon'.tr(),
      time: 2,
      color: charts.ColorUtil.fromDartColor(Colors.lightBlue),
    ),
    BarChartModel(
      days: 'Tues'.tr(),
      time: 2,
      color: charts.ColorUtil.fromDartColor(Colors.lightBlue),
    ),
    BarChartModel(
      days: 'Wed'.tr(),
      time: 3,
      color: charts.ColorUtil.fromDartColor(Colors.lightBlue),
    ),
    BarChartModel(
      days: 'Thurs'.tr(),
      time: 4,
      color: charts.ColorUtil.fromDartColor(Colors.lightBlue),
    ),
    BarChartModel(
      days: 'Fri'.tr(),
      time: 7,
      color: charts.ColorUtil.fromDartColor(Colors.lightBlueAccent),
    ),
    BarChartModel(
      days: 'Sat'.tr(),
      time: 6,
      color: charts.ColorUtil.fromDartColor(Colors.lightBlue),
    ),
    BarChartModel(
      days: 'Sun'.tr(),
      time: 5,
      color: charts.ColorUtil.fromDartColor(Colors.lightBlue),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final userProvider = Provider.of<Auths>(context);
    return Scaffold(
      body: BlocProvider(
          create: (context) => NetworkBloc()..add(ListenConnection()),
          child: BlocBuilder<NetworkBloc, NetworkState>(
            builder: (context, state) {
              if (state is ConnectionFailure)
                return Scaffold(
                    body: Center(
                        child: Image.asset('assets/png/no-internet-.jpg')));
              if (state is ConnectionSuccess) {
                return Scaffold(
                  key: _scaffoldKey,
                  appBar: _appBar(),
                  backgroundColor: LightColor.background,
                  body: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 22, 12, 10),
                    child: Column(
                      children: [
                        // give the tab bar a height [can change height to preferred height]
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(
                              20.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(.03),
                            child: TabBar(
                              controller: _tabController,
                              // give the indicator a decoration (color and border radius)
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  15.0,
                                ),
                                color: Colors.white,
                              ),
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.white,
                              tabs: [
                                // first tab [you can add an icon using the icon property]
                                Tab(
                                  text: 'DashBoard',
                                ),

                                // second tab [you can add an icon using the icon property]
                                Tab(
                                  text: 'Usage',
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// Tab bar view here
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              // first tab bar view widget
                              CustomScrollView(
                                slivers: <Widget>[
                                  SliverList(
                                    delegate: SliverChildListDelegate(
                                      [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        HorizontalList(),
                                        _header(),
                                        BarChartGraph(
                                          data: data,
                                        ),
                                        _category(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                          children: <Widget>[
                                            Text(
                                                'Installed Apps'
                                                    .tr()
                                                    .toString(),
                                                style:
                                                    TextStyles.titleNormal),
                                            IconButton(
                                                    icon: Icon(
                                                      Icons.sort,
                                                      color:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                    ),
                                                    onPressed: () {})
                                                .p(12)
                                                .ripple(() {
                                              Navigator.pushNamed(context,
                                                  '/installed_apps');
                                            },
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                          ],
                                        ).hP16,
                                        SizedBox(
                                          child: FutureBuilder<
                                                  List<Application>>(
                                              future: DeviceApps
                                                  .getInstalledApplications(
                                                      includeAppIcons: true,
                                                      includeSystemApps:
                                                          false,
                                                      onlyAppsWithLaunchIntent:
                                                          true,
                                                      usageApps: false),
                                              builder: (BuildContext
                                                      context,
                                                  AsyncSnapshot<
                                                          List<Application>>
                                                      data) {
                                                if (data.data == null) {
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                } else {
                                                  var apps = data.data;
                                                  print(apps);
                                                  return ListView.builder(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (BuildContext
                                                                  context,
                                                              int position) {
                                                        var app =
                                                            apps[position];
                                                        return Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      18,
                                                                  vertical:
                                                                      8),
                                                          child: ListTile(
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .all(0),
                                                            leading:
                                                                ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          13)),
                                                              child:
                                                                  Container(
                                                                height: 45,
                                                                width: 45,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          15),
                                                                  color: Colors
                                                                      .transparent,
                                                                ),
                                                                child: app
                                                                        is ApplicationWithIcon
                                                                    ? Image
                                                                        .memory(
                                                                        app.icon,
                                                                      )
                                                                    : null,
                                                              ),
                                                            ),
                                                            title: Text(
                                                                app.appName,
                                                                style: TextStyles
                                                                    .titleSize15),
                                                            subtitle:
                                                                LinearPercentIndicator(
                                                              width: 180.0,
                                                              lineHeight:
                                                                  8.0,
                                                              percent:
                                                                  getRandom(),
                                                              progressColor:
                                                                  Colors
                                                                      .blue,
                                                            ),
                                                            trailing: Icon(
                                                              Icons
                                                                  .keyboard_arrow_right,
                                                              size: 30,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                        ).ripple(() {
                                                          DeviceApps.openApp(
                                                              app.packageName);
                                                        },
                                                            borderRadius: BorderRadius
                                                                .all(Radius
                                                                    .circular(
                                                                        20)));
                                                      },
                                                      itemCount: 4);
                                                }
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              /// Second tab bar view widget
                              ListView.builder(
                                  itemCount: _infos.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                        title: Text(_infos[index].appName),
                                        trailing: Text(
                                            _infos[index].usage.toString()));
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Text('');
              }
            },
          )),
    );
  }
}
