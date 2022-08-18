import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget music_card(String title, String desc ,bool selected, String image){
  return Container(
    height: 77,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color:   selected ? Colors.white.withOpacity(0.2):Colors.transparent,
    ),
margin: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 5,),
        Container(
          height: 70,
          width: 70,
           decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),        
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                            image))),
        ),
        SizedBox(width: 5,),
        Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Wrap(children:[ Text(title,style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize:14,fontWeight: FontWeight.normal),)]),
             Text(desc,style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize:10,fontWeight: FontWeight.normal),),


          ],
        )
      ],
    ),
  );
}