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
      appBar: buildAppBar(),
      body: Column(
        children: <Widget>[
          Padding(
          padding: EdgeInsets.all(10),
          child: buildSearchBox(),
          ),
          Expanded(
            child: FutureBuilder(
              future: getGIF(),
              builder: (context, snapshot){
                switch (snapshot.connectionState){
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return buildLoading();
                default:
                  if (snapshot.hasError) return Container();
                  else return createGridGIF(context, snapshot);
                }
              }
            )
          )
        ],  
      )
    );
  }
}