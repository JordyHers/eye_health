
import 'package:eye_test/models/users.dart';
import 'package:eye_test/services/Api/Auths.dart';
import 'package:eye_test/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HorizontalList extends StatefulWidget {

  // const HorizontalList ({Key key, this.user}) : super(key: key);
  @override
  _HorizontalListState createState() => _HorizontalListState();
}


class _HorizontalListState extends State<HorizontalList> {


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<Auths>(context);
    return Container(
      decoration: BoxDecoration(
        color:  Colors.grey.withOpacity(0.1),
          borderRadius:  BorderRadius.all(Radius.circular(8))
      ),
      //color: Colors.grey,
      height: 150.0,
      width: double.infinity,
      child:  ListView.builder(
         itemCount: userProvider.currentUser.childMod.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return Kids(
            // image_location: 'assets/children/Carla.jpg',
            image_location: userProvider.currentUser.childMod[index].image,
            image_caption: userProvider.currentUser.childMod[index].name,
            //image_caption: 'Carla',
          );
        }

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