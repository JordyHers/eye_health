
import 'package:eye_test/models/users.dart';
import 'package:eye_test/services/Api/Auths.dart';
import 'package:eye_test/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HorizontalList extends StatefulWidget {
  @override
  _HorizontalListState createState() => _HorizontalListState();
}


class _HorizontalListState extends State<HorizontalList> {


  @override
  Widget build(BuildContext context) {


    return  Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      //color: Colors.grey,
      height: 150.0,
      width: double.infinity,
      child:  Kids(
        image_caption: 'Carla',
        image_location: 'assets/children/Carla.jpg',
        onPressed: null,
      ),
    );
  }
}



class Kids extends StatelessWidget {
  final String image_location;
  final String image_caption;
  final Function onPressed;

  Kids({this.image_location, this.image_caption,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:3.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 200,
          width: 150.0,
          child: ListTile(
              title: ClipOval(
                child: Image.network(
                  image_location,
                  fit: BoxFit.fitHeight,
                  width: 120,
                  height: 120,
                ),
              ),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(image_caption, style: TextStyles.body.bold.grey,),
              )
          ),
        ),
      ),
    );
  }
}