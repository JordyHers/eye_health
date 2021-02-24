import 'package:app_usage/app_usage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eye_test/services/Api/Auths.dart';
import 'package:eye_test/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class OpeningPage extends StatefulWidget {
  @override
  _OpeningPageState createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage> {
  bool _isParent = false;
  bool _isChild = false;

  var color  = Colors.green.withOpacity(0.5);




  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<Auths> (context);
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          SizedBox(
            height: 70,
          ),
          Container(
            height: 40,
              child: Image.asset('assets/images/Iphone.png')),
          SizedBox(
            height: 15,
          ),
          Text(
            'First, who uses this device ?',
            style: TextStyles.headTitleColored,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Row(
              children: [
                Column(
                  children: [
                    InkWell(onTap: (){
                      setState(() {
                        _isParent =true;
                        _isChild =false;

                       print('isTap activated Parents');
                      });
                    },
                      child: Card(
                        margin: EdgeInsets.only(
                            left: 45, right: 45, bottom: 20, top: 10),
                        child: Container(

                          color: _isParent ? color: Colors.transparent,
                          height: 80,
                          width: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/parents.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Parents',
                      style: TextStyles.body.black,
                    )
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                         _isParent =false;
                         _isChild = true;

                          print('isTap  kids activated');
                        });
                      },
                      child: Card(
                        margin: EdgeInsets.only(
                            left: 45, right: 40, bottom: 20, top: 10),
                        child: Container(
                          color: _isChild ? color: Colors.transparent,
                          height: 80,
                          width: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/sister-and-brother.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Children',
                      style: TextStyles.body.black,
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text('This lets us setup the app in the right \n'
              'way for this device. The Parent device will\n'
              'manage the child device.'),
          SizedBox(
            height: 100,
          ),
          RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: LightColor.accentBlue,
            onPressed: () async {

              userProvider.getUsageStats();
              _isParent ? await Navigator.pushReplacementNamed(context, '/Sign_in') : Navigator.pushNamed(context, '/child_home');

            },
            child: Text(
              'Next'.tr(),
              style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28.0, 8, 8, 8),
            child: ListTile(
              leading: Icon(Icons.bluetooth_connected_sharp),
              title: Text(
                'Is this A shared device ?',
                style: TextStyle(fontSize: 17, color: Colors.deepOrange),
              ),
            ),
          )
        ],
      )),
    );
  }
}
