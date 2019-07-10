import 'package:flutter/material.dart';
import 'package:aula_flutter_busca_gif/pages/page.home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Busca GIFs",
      debugShowCheckedModeBanner: false,
      home: Home()
    );
  }
}