

import 'package:eye_test/models/data.dart';
import 'package:eye_test/models/doctors_model.dart';
import 'package:eye_test/screens/home_page/Homepage.dart';
import 'package:eye_test/theme/extention.dart';
import 'package:eye_test/screens/profile_page/profile_page_constants.dart';
import 'package:eye_test/theme/light_color.dart';
import 'package:eye_test/theme/text_style.dart';
import 'package:flutter/material.dart';

class DoctorsPage extends StatefulWidget {
  @override
  _DoctorsPageState createState() => _DoctorsPageState();
}
List<DoctorModel> doctorDataList;

 @override
  void initState(){


 }





class _DoctorsPageState extends State<DoctorsPage> {
  Widget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kAppPrimaryColor,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.message,
            size: 30,
            color: Colors.black,
          ),
          onPressed: () {

          },
        ),


      ],
    );
  }

  Widget _doctorTile(DoctorModel model) {
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
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey,
              ),
              child: Image.asset(
                model.image,
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text(model.name, style: TextStyles.title.bold),
          subtitle: Text(
            model.type,
            style: TextStyles.bodySm.subTitleColor.bold,
          ),

        ),
      ).ripple(() {
         Navigator.pushNamed(context, "/DetailPage", arguments: model);
      }, borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }

  Widget getdoctorWidgetList() {
    return Column(
        children: doctorDataList.map((x) {
          return _doctorTile(x);
        }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: _appBar(),
      body: SafeArea(
        child: getdoctorWidgetList(),
      ),
    );
  }
}
