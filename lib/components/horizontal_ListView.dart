import 'package:eye_test/theme/theme.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      //color: Colors.grey,
      height: 150.0,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Kids(
            image_location: 'assets/children/Kyle.jpg',
            image_caption: 'Kyle',
            onPressed: null,
          ),
          Kids(
            image_location: 'assets/children/Mira.jpg',
            image_caption: 'Mira',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}

class Kids extends StatelessWidget {
  final String image_location;
  final String image_caption;
  final Function onPressed;

  Kids({this.image_location, this.image_caption, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0),
      child: InkWell(
        onTap: onPressed,
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
                child: Text(
                  image_caption,
                  style: TextStyles.body.bold.grey,
                ),
              )),
        ),
      ),
    );
  }
}
