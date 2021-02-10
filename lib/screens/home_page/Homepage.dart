import 'dart:io';

import 'package:algolia/algolia.dart';
import 'package:eye_test/models/apps_data.dart';
import 'package:eye_test/models/apps_model.dart';
import 'package:eye_test/models/users.dart';

import 'package:eye_test/screens/profile_page/profile_page_constants.dart';
import 'package:eye_test/services/AlgoliaSearch/search_bar_algolia.dart';
import 'package:eye_test/services/Api/Auths.dart';
import 'package:eye_test/services/Internet_Connection/bloc.dart';
import 'package:eye_test/services/Internet_Connection/network_bloc.dart';
import 'package:eye_test/widgets/bar_charts/bar_charts_graph.dart';
import 'package:eye_test/widgets/bar_charts/bar_charts_model.dart';
import 'package:eye_test/widgets/line_graph/line_graph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:eye_test/screens/exams_page/exams_page.dart';
import 'package:eye_test/screens/profile_page/profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:easy_localization/easy_localization.dart';

//_++++++++++++++++++++++++++++++   MY IMPORTS ++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
import 'package:eye_test/theme/theme.dart';
import 'package:charts_flutter/flutter.dart' as charts;
class HomePage extends StatefulWidget {
  static String routeName = "/homePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final picker = ImagePicker();
  UserModel _currentUser;

  //OrderModel _orderModel;
  String _imageUrl;
  File _imageFile;
  Status _status = Status.Uninitialized;

  Status get status => _status;
  int currentPage = 0;
  List<Widget> pages;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<Auths>(context, listen: false);
    userProvider.reloadUserModel();

    if (userProvider.currentUser != null) {
      _currentUser = userProvider.currentUser;
    } else {
      _currentUser = UserModel();
    }
    _imageUrl = _currentUser.image;
    HomePageBody homePageBody = HomePageBody();
    ExamsPage examsPage = ExamsPage();
    ProfilePage profilePage = ProfilePage();
    SearchBar searchBar = SearchBar();

    pages = [homePageBody, examsPage, examsPage,examsPage , profilePage];
  }

  void changePage(int value) {
    setState(() {
      currentPage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<Auths>(context);
    return Scaffold(
        body: BlocProvider(
            create: (context) => NetworkBloc()..add(ListenConnection()),
            child: BlocBuilder<NetworkBloc, NetworkState>(
              builder: (context, state) {
                if (state is ConnectionFailure) return Scaffold(
                    body: Center(
                        child: Image.asset("assets/png/no-internet-.jpg")));
                if (state is ConnectionSuccess)
                  return pages[currentPage];
                else
                  return Text("");
              },
            )),
        bottomNavigationBar: ConvexAppBar(

            backgroundColor: kAppPrimaryColor,
            elevation: 0,
            activeColor: LightColor.grey,
            items: [
              TabItem(icon: Center(child: FaIcon(FontAwesomeIcons.home))),
              TabItem(icon: Center(child: FaIcon(FontAwesomeIcons.invision))),
              TabItem(icon: Center(child: FaIcon(FontAwesomeIcons.plus))),
              TabItem(
                icon: Center(child: FaIcon(FontAwesomeIcons.peopleArrows)),
              ),
              TabItem(
                  icon: Center(
                      child: Icon(
                Icons.more_vert,
                size: 30,
              ))),
            ],
            initialActiveIndex: 2,
            //optional, default as 0
            onTap: changePage));
  }
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//_____________________________________ HOME PAGE body ______________________________________________________

class HomePageBody extends StatefulWidget {
  HomePageBody({Key key}) : super(key: key);

  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  List <AppsModel>  appsDataList;

  final picker = ImagePicker();
  UserModel _currentUser;
  final Algolia _algoliaApp = AlgoliaApplication.algolia;
  String _searchTerm;

  Future<List<AlgoliaObjectSnapshot>> _operation(String input) async {
    AlgoliaQuery query = _algoliaApp.instance.index("Doctors").search(input);
    AlgoliaQuerySnapshot querySnap = await query.getObjects();
    List<AlgoliaObjectSnapshot> results = querySnap.hits;
    return results;
  }

  String _imageUrl;
  File _imageFile;
  Status _status = Status.Uninitialized;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Status get status => _status;

  @override
  void initState() {
    appsDataList = appsMapList.map((k) => AppsModel.fromJson(k)).toList();

    super.initState();
    final userProvider = Provider.of<Auths>(context, listen: false);
    userProvider.reloadUserModel();

    if (userProvider.currentUser != null) {
      _currentUser = userProvider.currentUser;
      // _orderModel = userProvider.currentOrder;
    } else {
      _currentUser = UserModel();
      //_orderModel = OrderModel();
    }
    _imageUrl = _currentUser.image;
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kAppPrimaryColor,
      leading: IconButton(
        icon: Icon(
          Icons.notifications,
          size: 30,
          color: Colors.black,
        ),
        onPressed: () {

        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            size: 30,
            color: LightColor.grey,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/search_bar_algolia');

          },
        ),

        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/hero_animation_profile_page');
          },
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              // height: 40,
              // width: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
              ),
              child: _imageFile == null && _imageUrl == null
                  ? Image.asset("assets/images/users.jpg", fit: BoxFit.fill)
                  : Hero(
                      tag: 'profile',
                      child: Image.network(
                        _imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
            ),
          ).p(8),
        ),
      ],
    );
  }

  Widget _header() {
    final userProvider = Provider.of<Auths>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("hello".tr().toString(), style: TextStyles.title.subTitleColor),
        Text(userProvider.userModel?.name ?? "user".tr().toString(),
            style: TextStyles.h3Large),
      ],
    ).p16;
  }

  // Widget _searchField() {
  //   return GestureDetector(
  //
  //     child: Column(
  //       children: [
  //         Container(
  //           height: 55,
  //           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  //           width: MediaQuery.of(context).size.width,
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.all(Radius.circular(13)),
  //             boxShadow: <BoxShadow>[
  //               BoxShadow(
  //                 color: LightColor.grey.withOpacity(.3),
  //                 blurRadius: 15,
  //                 offset: Offset(5, 5),
  //               )
  //             ],
  //           ),
  //           child: TextField(
  //
  //             decoration: InputDecoration(
  //               contentPadding:
  //                   EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  //               border: InputBorder.none,
  //               hintText: "search".tr().toString(),
  //               hintStyle: TextStyles.body.subTitleColor,
  //               suffixIcon: SizedBox(
  //                   width: 50,
  //                   child: Icon(Icons.search, color: LightColor.purple)
  //                       .alignCenter
  //                       .ripple(() {}, borderRadius: BorderRadius.circular(13))),
  //             ),
  //           ),
  //         ),
  //
  //       ],
  //     ),
  //   );
  // }

  Widget _category() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("category".tr().toString(), style: TextStyles.titleNormal),
              Text(
                "see all".tr().toString(),
                style: TextStyles.titleNormal
                    .copyWith(color: Theme.of(context).primaryColor),
              ).p(8).ripple(() {
                Navigator.pushNamed(context, '/see_more_page');
              })
            ],
          ),
        ),
        SizedBox(
          height: AppTheme.fullHeight(context) * .28,
          width: AppTheme.fullWidth(context),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _categoryCardFocus("focus mode".tr().toString(), "concentrate".tr().toString(),
                  color: LightColor.purple, lightColor: LightColor.purpleLight),
              _categoryCardScreenTime( "screen time".tr().toString(),
                  color: LightColor.skyBlue, lightColor: LightColor.lightBlue),
              // _categoryCardHospital("hospitals".tr().toString(), "35 " + "near you".tr().toString(),
              //     color: LightColor.green, lightColor: LightColor.lightGreen),
              // _categoryCardDark("dark mode".tr().toString(), "relax".tr().toString(),
              //     color: LightColor.orange, lightColor: LightColor.lightOrange),
            ],
          ),
        ),
      ],
    );
  }

  ///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ///++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ///_______________________-WIDGET HOSPITAL _________________________________________________________

  Widget _categoryCardHospital(String title, String subtitle,
      {Color color, Color lightColor}) {
    TextStyle titleStyle = TextStyles.title.bold.white;
    TextStyle subtitleStyle = TextStyles.body.bold.white;
    if (AppTheme.fullWidth(context) < 392) {
      titleStyle = TextStyles.body.bold.white;
      subtitleStyle = TextStyles.bodySm.bold.white;
    }
    return AspectRatio(
      aspectRatio: 6 / 8,
      child: Container(
        height: 280,
        width: AppTheme.fullWidth(context) * .3,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/search-hospital.jpg'),
            fit: BoxFit.fitHeight,
          ),
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: lightColor.withOpacity(.4),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Text(title, style: titleStyle).hP8,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Text(
                        subtitle,
                        style: subtitleStyle,
                      ).hP8,
                    ),
                  ],
                ).p16
              ],
            ),
          ),
        ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }

  ///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ///++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ///_______________________-WIDGET FOCUS MODE _________________________________________________________

  Widget _categoryCardFocus(String title, String subtitle,
      {Color color, Color lightColor}) {
    TextStyle titleStyle = TextStyles.title.bold.white;
    TextStyle subtitleStyle = TextStyles.body.bold.white;
    if (AppTheme.fullWidth(context) < 392) {
      titleStyle = TextStyles.body.bold.white;
      subtitleStyle = TextStyles.bodySm.bold.white;
    }
    return AspectRatio(
      aspectRatio: 6 / 8,
      child: Container(
        height: 280,
        width: AppTheme.fullWidth(context) * .3,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/focus_mode.jpg'),
            fit: BoxFit.cover,
          ),
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: lightColor.withOpacity(.4),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                // Positioned(
                //   top: -20,
                //   left: -20,
                //   child: CircleAvatar(
                //     backgroundColor: lightColor,
                //     radius: 60,
                //   ),
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Text(title, style: titleStyle).hP8,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Text(
                        subtitle,
                        style: subtitleStyle,
                      ).hP8,
                    ),
                  ],
                ).p16
              ],
            ),
          ),
        ).ripple(() {
          Navigator.pushNamed(context, '/focus_mode');
        }, borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }

  ///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ///++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ///_______________________-WIDGET SCREEN TIME _________________________________________________________
  Widget _categoryCardScreenTime( String subtitle,
      {Color color, Color lightColor}) {
    TextStyle titleStyle = TextStyles.title.bold.white;
    TextStyle subtitleStyle = TextStyles.body.bold.black;
    if (AppTheme.fullWidth(context) < 392) {
      titleStyle = TextStyles.body.bold.black;
      subtitleStyle = TextStyles.bodySm.bold.grey;
    }
    return AspectRatio(
      aspectRatio: 6 / 8,
      child: Container(
        height: 280,
        width: AppTheme.fullWidth(context) * .3,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/screen_time2.jpg'),
            fit: BoxFit.cover,
          ),
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: lightColor.withOpacity(.4),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                // Positioned(
                //   top: -20,
                //   left: -20,
                //   child: CircleAvatar(
                //     backgroundColor: lightColor,
                //     radius: 60,
                //   ),
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Text(
                        subtitle,
                        style: subtitleStyle,
                      ).hP8,
                    ),
                  ],
                ).p16
              ],
            ),
          ),
        ).ripple(() {
          Navigator.pushNamed(context, '/screen_time');
        }, borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }

  ///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ///++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ///_______________________-WIDGET DARK MODE _________________________________________________________

  Widget _categoryCardDark(String title, String subtitle,
      {Color color, Color lightColor}) {
    TextStyle titleStyle = TextStyles.title.bold.white;
    TextStyle subtitleStyle = TextStyles.body.bold.black;
    if (AppTheme.fullWidth(context) < 392) {
      titleStyle = TextStyles.body.bold.black;
      subtitleStyle = TextStyles.bodySm.bold.grey;
    }
    return AspectRatio(
      aspectRatio: 6 / 8,
      child: Container(
        height: 280,
        width: AppTheme.fullWidth(context) * .3,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/dark_mode.jpg'),
            fit: BoxFit.cover,
          ),
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: lightColor.withOpacity(.4),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                // Positioned(
                //   top: -20,
                //   left: -20,
                //   child: CircleAvatar(
                //     backgroundColor: lightColor,
                //     radius: 60,
                //   ),
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Text(title, style: titleStyle).hP8,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Text(
                        subtitle,
                        style: subtitleStyle,
                      ).hP8,
                    ),
                  ],
                ).p16
              ],
            ),
          ),
        ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }

  Widget _appsList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("most used apps".tr().toString(), style: TextStyles.titleNormal),
              IconButton(
                  icon: Icon(
                    Icons.sort,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/see_more_doctors');
                  })
              // .p(12).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
            ],
          ).hP16,
          getMostUsedApps(),

        ],
      ),
    );
  }


  Widget getMostUsedApps() {
    return Column(
        children: appsDataList.map((x) {
      return _appsTile(x);
    }).toList());
  }




  Widget _appsTile(AppsModel model) {
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



  Color randomColor() {
    var random = Random();
    final colorList = [
      LightColor.grey,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }
  final List<BarChartModel> data = [
    BarChartModel(
      days: "Monday".tr(),
      time: 25,
      color: charts.ColorUtil.fromDartColor(Colors.lightBlue),
    ),
    BarChartModel(
      days:"Tuesday".tr(),
      time: 30,
      color: charts.ColorUtil.fromDartColor(Colors.lightBlue),
    ),
    BarChartModel(
      days: "Wednesday".tr(),
      time: 10,
      color: charts.ColorUtil.fromDartColor(Colors.lightBlue),
    ),
    BarChartModel(
      days: "Thursday".tr(),
      time: 24,
      color: charts.ColorUtil.fromDartColor(Colors.lightBlue),
    ),
    BarChartModel(
      days: "Friday".tr(),
      time: 30,
      color: charts.ColorUtil.fromDartColor(Colors.lightBlueAccent),
    ),
    BarChartModel(
      days: "Saturday".tr(),
      time: 11,
      color: charts.ColorUtil.fromDartColor(Colors.lightBlue),
    ),
    BarChartModel(
      days: "Sunday".tr(),
      time: 53,
      color: charts.ColorUtil.fromDartColor(Colors.lightBlue),
    ),
  ];
//==================================================================HOME PAGE BODY +++++++++++++++++++++++++++++++++++
  @override
  Widget build(BuildContext context) {
    Auths _auths = Auths.initialize();
    final userProvider = Provider.of<Auths>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(),
      backgroundColor: kAppPrimaryColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _header(),
                BarChartGraph(
                  data: data,
                ),
                LineChartSample1(),
                _category(),
              ],
            ),
          ),
          _appsList()
        ],
      ),
    );
  }
}
//________________________________________________________________________________
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++==
// Widget _categoryCardHospital(String title, String subtitle,
//     {Color color, Color lightColor}) {
//   TextStyle titleStyle = TextStyles.title.bold.white;
//   TextStyle subtitleStyle = TextStyles.body.bold.white;
//   if (AppTheme.fullWidth(context) < 392) {
//     titleStyle = TextStyles.body.bold.white;
//     subtitleStyle = TextStyles.bodySm.bold.white;
//   }
//   return AspectRatio(
//     aspectRatio: 6 / 8,
//     child: Container(
//       height: 280,
//       width: AppTheme.fullWidth(context) * .3,
//       margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
//       decoration: BoxDecoration(
//         image:  DecorationImage(
//           image:  AssetImage('assets/images/dark_mode.jpg'),
//           fit: BoxFit.cover,
//         ),
//         color: color,
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//         boxShadow: <BoxShadow>[
//           BoxShadow(
//             offset: Offset(4, 4),
//             blurRadius: 10,
//             color: lightColor.withOpacity(.8),
//           )
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//         child: Container(
//           child: Stack(
//             children: <Widget>[
//               Positioned(
//                 top: -20,
//                 left: -20,
//                 child: CircleAvatar(
//                   backgroundColor: lightColor,
//                   radius: 60,
//                 ),
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   Flexible(
//                     child: Text(
//                         title,
//                         style: titleStyle
//                     ).hP8,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Flexible(
//                     child: Text(
//                       subtitle,
//                       style: subtitleStyle,
//                     ).hP8,
//                   ),
//                 ],
//               ).p16
//             ],
//           ),
//         ),
//       ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
//     ),
//   );
// }
