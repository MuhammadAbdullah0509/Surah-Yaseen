import 'package:flutter/material.dart';
class Styles{
  static Color highlight=Colors.blue.shade200;
  static Color appbar=const Color(0xff174780);
  static Color white=Colors.white;
  static Color whiteLight=const Color(0x00ffffff);
  static Color searchBoxBackground=const Color(0xff7c7c7c).withOpacity(0.3);
  static TextStyle size18=const TextStyle(fontSize: 18.0);
  static Color indexColor=Colors.blue.shade200;

  //Search box
  static searchBox(){
   return Padding(
     padding: const EdgeInsets.all(10.0),
     child: Container(
       height: 50,
       decoration: BoxDecoration(
         color: searchBoxBackground,
         borderRadius: BorderRadius.circular(15)
       ),
       child: TextFormField(
         decoration: InputDecoration(
           hintText: "Search",
           prefixIcon: const Icon(Icons.search),
           enabledBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10),
           ),
           focusedBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10),
           ),
         ),
       ),
     ),
   );
  }
}