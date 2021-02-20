import 'package:eye_test/theme/theme.dart';
import 'package:flutter/material.dart';


class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
          borderRadius:  BorderRadius.all(Radius.circular(8))
      ),
      //color: Colors.grey,
      height: 150.0,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[

          Kids(
            image_location: 'assets/children/Carla.jpg',
            image_caption: 'Carla',
          ),

          Kids(
            image_location: 'assets/children/Lenny.jpg',
            image_caption: 'Lenny',
          ),

          Kids(
            image_location: 'assets/children/Mira.jpg',
            image_caption: 'Mira',
          ),

          Kids(
            image_location: 'assets/children/Kyle.jpg',
            image_caption: 'Kyle',
          ),




        ],
      ),
    );
  }
}

class Kids extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Kids({this.image_location, this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:3.0),
      child: InkWell(
        onTap: () {

        },
        child: Container(
          height: 200,
          width: 150.0,
          child: ListTile(
              title: ClipOval(
                child: Image.asset(
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