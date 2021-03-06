// Widget _category() {
//   return Column(
//     children: <Widget>[
//       Padding(
//         padding: EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Text('category'.tr().toString(), style: TextStyles.titleNormal),
//           ],
//         ),
//       ),
//       SizedBox(
//         height: 100,
//         width: AppTheme.fullWidth(context),
//         child: ListView(
//           scrollDirection: Axis.horizontal,
//           children: <Widget>[
//             SizedBox(
//               height: 20,
//               width: 20,
//             ),
//             _categoryCardFocus(
//                 'focus mode'.tr().toString(), 'concentrate'.tr().toString(),
//                 color: LightColor.purple, lightColor: LightColor.purpleLight),
//             SizedBox(
//               height: 20,
//               width: 20,
//             ),
//             // _categoryCardFindOnMap('Find on Map'.tr().toString(),
//             //     color: LightColor.skyBlue, lightColor: LightColor.lightBlue),
//           ],
//         ),
//       ),
//     ],
//   );
// }
//
// ///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// ///++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// ///_______________________-WIDGET FOCUS MODE _________________________________________________________
//
// Widget _categoryCardFocus(String title, String subtitle,
//     {Color color, Color lightColor}) {
//   var titleStyle = TextStyles.title.bold.white;
//   var subtitleStyle = TextStyles.body.bold.white;
//   // if (AppTheme.fullWidth(context) < 392) {
//   //   titleStyle = TextStyles.body.bold.white;
//   //   subtitleStyle = TextStyles.bodySm.bold.white;
//   // }
//   return Container(
//     height: 40,
//     decoration: BoxDecoration(
//       image: DecorationImage(
//         image: AssetImage('assets/images/Meditation-rafiki.png'),
//         fit: BoxFit.contain,
//       ),
//       color: color,
//       borderRadius: BorderRadius.all(Radius.circular(20)),
//     ),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: <Widget>[
//         SizedBox(
//           height: 10,
//         ),
//         Flexible(
//           child: Text(
//             subtitle,
//             style: TextStyles.titleNormal,
//           ).hP8,
//         ),
//       ],
//     ).p16.ripple(() {
//       Navigator.pushNamed(context, '/focus_mode');
//     }, borderRadius: BorderRadius.all(Radius.circular(20))),
//   );
// }



// Widget getMostUsedApps() {
//   return Column(
//       children: appsDataList.map((x) {
//     return _appsTile(x);
//   }).toList());
// }
