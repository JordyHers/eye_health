import 'package:eye_test/screens/profile_page/profile_page_constants.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';


class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final Function onPressed;

  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.onPressed,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 55,
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ).copyWith(
          bottom: 20,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey.shade300,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              this.icon,
              size: 25,
            ),
            SizedBox(width: 15),
            Text(
              this.text,
              style: kTitleTextStyle.copyWith(
                  fontWeight: FontWeight.w500,

              ),
            ),
            Spacer(),
            if (this.hasNavigation)
              Icon(
                LineAwesomeIcons.angle_right,
                size: 25,
              ),
          ],
        ),
      ),
    );
  }
}