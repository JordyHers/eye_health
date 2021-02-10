import 'package:easy_localization/easy_localization.dart';
import 'package:eye_test/services/Api/Auths.dart';
import 'package:eye_test/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SettingsPage  extends StatefulWidget  {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with ChangeNotifier  {

  // @override
  // void dispose() {
  //   super.dispose();
  //  _SettingsPageState _settingsPageState = new _SettingsPageState();
  //   _settingsPageState.dispose();
  // }
 // bool isUpdated;
  @override
  Widget build(BuildContext context) {
    final isUpdated = Provider.of<Auths>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('settings'.tr().toString() ,style: TextStyles.titleMedium,),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(height: 10,),
          GestureDetector(
              onTap: () {
                setState(() {
                  EasyLocalization.of(context).locale = Locale('en','US');
                });
                Fluttertoast.showToast(msg: 'Update successful',backgroundColor: LightColor.green);
                setState(() {
                  isUpdated.reloadUserModel();
                  notifyListeners();
                });

              },
              child: Text(
                " English",
                style: TextStyles.titleMedium,
              )),
          Divider(thickness: .5,color: Colors.grey,),

          GestureDetector(
              onTap: () {
                setState(() {
                  EasyLocalization.of(context).locale = Locale('tr','TR');
                });
                Fluttertoast.showToast(msg: 'Bilgileriniz güncellendi',backgroundColor: LightColor.green);

                setState(() {
                  isUpdated.languageisUpdated();
                  print('bilgilerinizi guncellendi');
                  notifyListeners();
                });
              },
              child: Text(" Türkçe ", style: TextStyles.titleMedium)),
          Divider(thickness: .5,color: Colors.grey,),

          GestureDetector(
              onTap: () {
                setState(() {
                  EasyLocalization.of(context).locale = Locale('fr','FR');
                });
                Fluttertoast.showToast(msg: 'Mis a jour',backgroundColor: LightColor.green);
               setState(() {
                 isUpdated.languageisUpdated();
                 print('bilgilerinizi guncellendi');
                 notifyListeners();
               });

              }, child: Text(" Francais ", style: TextStyles.titleMedium))
        ],
      ),
    );
  }
}
