import 'package:flutter/material.dart';

final _imageTop = "https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif";

Widget buildAppBar(){
  return AppBar(
        backgroundColor: Colors.black,
        title: Image.network(_imageTop),
        centerTitle: true
      );
}