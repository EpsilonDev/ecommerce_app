import 'package:flutter/material.dart';

class CategorieItem extends StatelessWidget {

  final dynamic item;

  CategorieItem({ this.item });


  @override
  Widget build(BuildContext context) {

    final String picUrl = "http://10.0.3.2:1337${item['pic']['url']}";

    return Container(
      width: 70.0,
      height: 70.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        //border: Border.all(color: Theme.of(context).accentColor),
        image: new DecorationImage(
            fit: BoxFit.fill,
            image: new NetworkImage(picUrl),
      ),
      
    )
    
    );
  }
}
