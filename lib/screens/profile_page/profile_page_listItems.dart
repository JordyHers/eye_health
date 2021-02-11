import 'package:eye_test/theme/theme.dart';
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
              icon,
              size: 25,
            ),
            SizedBox(width: 15),
            Text(
              text,
              style: TextStyles.body,
            ),
            Spacer(),
            if (hasNavigation)
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