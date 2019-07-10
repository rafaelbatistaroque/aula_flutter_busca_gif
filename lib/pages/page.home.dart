import 'package:flutter/material.dart';
import 'package:aula_flutter_busca_gif/builder.widgets/home.widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar()
    );
  }
}