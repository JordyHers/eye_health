final appsMapList = [
  {
    "name": "Whatsapp ",
    "type": "Social Media",
    "usage": "2 hours 30 min",
    "isfavourite": true,
    "image":"assets/Apps/whatsapp.png",
  }, {
    "name": "Twitter",
    "type": "Social Media",
    "usage": "1hour 10 min",
    "isfavourite": true,
    "image":"assets/Apps/twitter.png",
  }, {
    "name": "Instagram ",
    "type": "Social Media",
    "usage": " 30 mins",
    "isfavourite": true,
    "image":"assets/Apps/instagram.png",
  }, {
    "name": " Google maps",
    "type": "Maps",
    "usage": "23 mins",
    "isfavourite": false,
    "image":"assets/Apps/google-maps.png",
  }, {
    "name": "Chrome ",
    "type": "Browser",
    "usage": " > 12 mins",
    "isfavourite": false,
    "image":"assets/Apps/chrome.png",
  }, {
    "name": "Youtube",
    "type": "Multimedia",
    "usage": "2 hours 30 min",
    "isfavourite": true,
    "image":"assets/Apps/youtube.png",
  }, {
    "name": "Netflix",
    "type": "Streaming",
    "usage": "  < 3 hours",
    "isfavourite": true,
    "image":"assets/Apps/netflix.png",
  },
  {
    "name": "Facebook",
    "type": "Social media",
    "usage": "  2 hours",
    "isfavourite": true,
    "image":"assets/Apps/facebook.png",
  },

  {
    "name": "Angry Birds",
    "type": "Game",
    "usage": "  18 mins",
    "isfavourite": true,
    "image":"assets/Apps/angry-birds.png",
  },
 ];

// import 'package:flutter/material.dart';
// import 'package:revolt/models.dart';
//
// import '../theme.dart';
//
// class StudentHome extends StatefulWidget {
//   StudentHome({Key key}) : super(key: key);
//
//   @override
//   _StudentHomeState createState() => _StudentHomeState();
// }
//
// class _StudentHomeState extends State<StudentHome> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//   List <SubjectsModel>  subjectsDataList;
//
//   @override
//   void initState() {
//     subjectsDataList = subjectMapList.map((k) => SubjectsModel.fromJson(k)).toList();
//   }
//
//
//
//   Widget _SubjectsList() {
//     return SliverList(
//       delegate: SliverChildListDelegate(
//         [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text("Öğrenebileceğiniz konular", style: TextStyles.titleNormal),
//               IconButton(
//                   icon: Icon(
//                     Icons.sort,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   onPressed: () {
//
//                   })
//
//             ],
//           ),
//           Column(
//               children: subjectsDataList.map((x) {
//                 return _subjectsTile(x);
//               }).toList()),
//
//         ],
//       ),
//     );
//   }
//   /// ---------------------------------------------------------
//   /// Here is the app bar of the app which can be changed
//   Widget _appBar() {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: ThemeColor.background,
//       leading: IconButton(
//         icon: Icon(
//           Icons.notifications,
//           size: 30,
//           color: Colors.black,
//         ),
//         onPressed: () {
//
//         },
//       ),
//       actions: <Widget>[
//         IconButton(
//           icon: Icon(
//             Icons.search,
//             size: 30,
//             color: ThemeColor.grey,
//           ),
//           onPressed: () {
//
//           },
//         ),
//
//         ClipRRect(
//           borderRadius: BorderRadius.all(Radius.circular(13)),
//           child: Container(
//             // height: 40,
//             // width: 40,
//               decoration: BoxDecoration(
//                 color: Theme.of(context).backgroundColor,
//               ),
//               child:Image.asset("assets/images/logo.png", fit: BoxFit.fill)
//
//           ),
//         ),
//       ],
//     );
//   }
//   Widget _subjectsTile(SubjectsModel model) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//         boxShadow: <BoxShadow>[
//           BoxShadow(
//             offset: Offset(4, 4),
//             blurRadius: 10,
//             color: ThemeColor.grey.withOpacity(.2),
//           ),
//           BoxShadow(
//             offset: Offset(-3, 0),
//             blurRadius: 15,
//             color: ThemeColor.grey.withOpacity(.1),
//           )
//         ],
//       ),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
//         child: ListTile(
//           contentPadding: EdgeInsets.all(0),
//           leading: ClipRRect(
//             borderRadius: BorderRadius.all(Radius.circular(13)),
//             child: Container(
//               height: 45,
//               width: 45,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: Colors.transparent,
//               ),
//               child: Image.asset(
//                 model.image,
//                 height: 15,
//                 width: 30,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//           title: Text(model.name, style: TextStyles.titleNormal),
//           subtitle: Text(
//             model.usage,
//             style: TextStyles.titleMedium,
//           ),
//           trailing: Icon(
//             Icons.keyboard_arrow_right,
//             size: 30,
//             color: Theme.of(context).primaryColor,
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: _appBar(),
//       backgroundColor: ThemeColor.background,
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverList(
//             delegate: SliverChildListDelegate(
//               [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text("Merhaba", style: TextStyles.titleNormal),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           _SubjectsList()
//         ],
//       ),
//     );
//   }
// }

