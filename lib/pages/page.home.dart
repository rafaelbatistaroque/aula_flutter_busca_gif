import 'package:aula_flutter_busca_gif/functions/function.request.dart';
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
      appBar: buildAppBar(),//Constrói a appBar.
      body: Column(
        children: <Widget>[
          Padding(
          padding: EdgeInsets.all(10),
          child: buildSearchBox(), //Constrói a caixa de pesquisa de GIFs.
          ),
          Expanded(
            child: FutureBuilder(
              future: getGIF(), //Faz a requisição do GIFs pela API.
              builder: createGridGIF// Constrói a grade de GIFs na body do App.
            )
          )
        ],  
      )
    );
  }
}