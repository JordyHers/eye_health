import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_apps/device_apps.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eye_test/components/geo_locate/geo.dart';
import 'package:eye_test/components/horizontal_ListView.dart';
import 'package:eye_test/models/apps_model.dart';
import 'package:eye_test/models/users.dart';
import 'package:eye_test/services/Api/Auths.dart';

//_++++++++++++++++++++++++++++++   MY IMPORTS ++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
import 'package:eye_test/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class ParentPage extends StatefulWidget {
  @override
  _ParentPageState createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage>
    with SingleTickerProviderStateMixin {
  final picker = ImagePicker();
  List<DocumentSnapshot> Apps = <DocumentSnapshot>[];

  final Status _status = Status.Uninitialized;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Status get status => _status;
  TabController _tabController;
   UserModel _currentUser;

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<Auths>(context, listen: false);
    userProvider.getUsageStats();
    userProvider.setTokenAndAppList();
    userProvider.reloadUserModel();
    if (userProvider.currentUser != null) {
      _currentUser = userProvider.currentUser;
    } else {
      _currentUser = UserModel();
    };
    _tabController = TabController(length: 2, vsync: this);
    userProvider.VerifyInfoscurrentUser();
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
          child: Text("Follow your child's location ".tr().toString(),
              style: TextStyles.titleNormal.bl_ac),
        ),
        Text('This is your location- Monitor '.tr().toString(),
            style: TextStyles.bodySm.subTitleColor),
      ],
    ).p16;
  }


  double getRandom() {
    var list = [0.1, 0.3, 0.7, 0.4, 0.6, 0.9, 0.65, 0.85];
    var rn = (list..shuffle()).first;
    return rn;
  }

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

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final userProvider = Provider.of<Auths>(context);
    userProvider.UserStream();
    return  Scaffold(
        key: _scaffoldKey,
        appBar: _appBar(),
        backgroundColor: LightColor.background,
        body: buildParentPageContent(context, userProvider) ,
    );
  }


  ///   buildParentPageContent(context, userProvider)
  Widget buildParentPageContent(BuildContext context, Auths userProvider) {
    return Padding(
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
                              height: 40,
                            ),
                            ListTile(
                              title: Text(
                                '  My Children'.tr().toString(),
                                style: TextStyles.titleNormal.bl_ac,
                              ),
                              subtitle: Text(
                                'Choose child to get more infos ',
                                style: TextStyles.bodySm.subTitleColor,
                              ),
                              trailing: Icon(Icons.info_outline_rounded),
                            ).p8,
                            Divider(
                              height: 5,
                              color: Colors.grey.withOpacity(0.1),
                              thickness: 3,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            HorizontalList(),
                            Divider(
                              height: 5,
                              color: Colors.grey.withOpacity(0.1),
                              thickness: 3,
                            ),
                            _header(),
                            Consumer<Position>(
                                builder: (context, position, widget) {
                              return (position != null)
                                  ? Geo(position)
                                  : Center(
                                      child: CircularProgressIndicator());
                            }),

                            // BarChartGraph(
                            //   data: data,
                            // ),
                            //_category(),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Installed Apps'.tr().toString(),
                                    style: TextStyles.titleNormal.bl_ac),
                                IconButton(
                                        icon: Icon(
                                          Icons.sort,
                                          color: LightColor.accentBlue,
                                        ),
                                        onPressed: () {})
                                    .p(12)
                                    .ripple(() {
                                  Navigator.pushNamed(
                                      context, '/installed_apps');
                                }, borderRadius: BorderRadius.all(Radius.circular(20))),
                              ],
                            ).hP16,
                            SizedBox(
                              child: FutureBuilder<List<Application>>(
                                  future: DeviceApps.getInstalledApplications(
                                      includeAppIcons: true,
                                      includeSystemApps: false,
                                      onlyAppsWithLaunchIntent: true,
                                      usageApps: false),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<Application>> data) {
                                    if (data.data == null) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else {
                                      var apps = data.data;
                                      print(apps);
                                      return ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int position) {
                                            var app = apps[position];
                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 18,
                                                  vertical: 8),
                                              child: ListTile(
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                leading: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              13)),
                                                  child: Container(
                                                    height: 45,
                                                    width: 45,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(15),
                                                      color:
                                                          Colors.transparent,
                                                    ),
                                                    child:
                                                        app is ApplicationWithIcon
                                                            ? Image.memory(
                                                                app.icon,
                                                              )
                                                            : null,
                                                  ),
                                                ),
                                                title: Text(app.appName,
                                                    style: TextStyles
                                                        .titleSize15),
                                                subtitle:
                                                    LinearPercentIndicator(
                                                  width: 180.0,
                                                  lineHeight: 8.0,
                                                  percent: getRandom(),
                                                  progressColor: Colors.blue,
                                                ),
                                                trailing: Icon(
                                                  Icons.keyboard_arrow_right,
                                                  size: 30,
                                                  color:
                                                      LightColor.accentBlue,
                                                ),
                                              ),
                                            ).ripple(() {
                                              DeviceApps.openApp(
                                                  app.packageName);
                                            },
                                                borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(20)));
                                          },
                                          itemCount: 1);
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
                      itemCount: userProvider.infos.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text(userProvider.infos[index].appName),
                            trailing: Text(
                                userProvider.infos[index].usage.toString()));
                      }),
                ],
              ),
            ),
          ],
        ),
      );
  }

 Widget _buildContents(BuildContext context) {
    final database = Provider.of<Auths> (context,listen:false);
    return StreamBuilder<List<UserModel>>(
      stream: database.UserStream(),
      builder: (context, snapshot){
        if (snapshot.hasData){

          final users = snapshot.data;
          final children = users.map((user) => Text(user.name)).toList();
          return ListView( children: children);
        }
        return Center (child: CircularProgressIndicator(),);

      },

    );

 }
}
