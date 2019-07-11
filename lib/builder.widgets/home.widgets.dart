import 'package:flutter/material.dart';
import 'package:aula_flutter_busca_gif/functions/function.request.dart';

final _imageTop = "https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif";

Widget buildAppBar(){
  return AppBar(
        backgroundColor: Colors.black,
        title: Image.network(_imageTop),
        centerTitle: true
      );
}

Widget buildSearchBox(){
  return TextField(
    decoration: InputDecoration(
      labelText: "Pesquisar",
      labelStyle: TextStyle(color: Colors.grey),
      border: OutlineInputBorder()
      ),
    style: TextStyle(color: Colors.grey),
    textAlign: TextAlign.center,
    onSubmitted: (text){
      search = text;
    },
  );
}

Widget buildLoading(){
  return Container(
          width: 200,
          height: 200,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
            strokeWidth: 5,
          ),
        );
}

Widget createGridGIF(BuildContext context, AsyncSnapshot snapshot){
  switch (snapshot.connectionState){
    case ConnectionState.waiting:
    case ConnectionState.none:
      return buildLoading(); //Constrói a animação circular de espera.
    default:
      if (snapshot.hasError)
        return Container();
      else
        return GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10
          ),
          itemCount: snapshot.data["data"].length,
          itemBuilder: (context, index){
            return GestureDetector(
              child: Image.network(snapshot.data["data"][index]["images"]["fixed_height"]["url"],
                height: 300,
                fit: BoxFit.cover,
                ),
            );
          }
        );
  }
}