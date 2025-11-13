import 'package:flutter/material.dart';

Color bannerColor = const Color(0xffc4d1da);
Color fbackgroundColor1 = const Color(0xffe7e8ea);
Color fbackgroundColor2 = const Color(0xfff4f4f4);
Color shadowColor = Color(0xffa4dced);
Color bannerShadowColor = Color(0xfff5f7f6);



Color getColorFromName(String colorName){
  switch(colorName){
    case 'red':
      return Colors.red;
    case 'green':
      return Colors.green;
    case 'pink':
      return Colors.pink;
    case 'bluegrey':
      return Colors.blueGrey;
    case 'blueAccent':
      return Colors.blueAccent;
    case 'blue':
      return Colors.blue;
    case 'black':
      return Colors.black;
    case 'black12':
      return Colors.black12;
    case 'yellow':
      return Colors.yellow;
    default:
      return Colors.blue[100]!;












  }
}