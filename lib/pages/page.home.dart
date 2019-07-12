import 'dart:convert';
import 'package:aula_flutter_busca_gif/pages/page.share.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

final String imageTop = "https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _search;
  int _offSet = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),//Constrói a appBar.
      body: Column(
        children: <Widget>[
          Padding(
          padding: EdgeInsets.all(10),
          child: _buildSearchBox(), //Constrói a caixa de pesquisa de GIFs.
          ),
          Expanded(
            child: FutureBuilder(
              future: _getGIF(), //Faz a requisição do GIFs pela API.
              builder: _createGridGIF// Constrói a grade de GIFs na body do App.
            )
          )
        ],  
      )
    );
  }

  Future<Map> _getGIF() async {
    http.Response response;

    if(_search == null)
      response = await http.get("https://api.giphy.com/v1/gifs/trending?api_key=L1yPbYOU9AcWGzIMsTYP10Dn6hK67Z6Z&limit=20&rating=G");
    else
      response = await http.get("https://api.giphy.com/v1/gifs/search?api_key=L1yPbYOU9AcWGzIMsTYP10Dn6hK67Z6Z&q=$_search&limit=20&offset=$_offSet&rating=G&lang=en");

    return json.decode(response.body);
  }
  int _getCount(List data){
    if(_search == null) return data.length;
    else return data.length + 1;
  }

  Widget _buildAppBar(){
    return AppBar(
      backgroundColor: Colors.black,
      title: Image.network(imageTop),
      centerTitle: true
    );
}

  Widget _buildSearchBox(){
  return TextField(
    decoration: InputDecoration(
      labelText: "Pesquisar",
      labelStyle: TextStyle(color: Colors.grey),
      border: OutlineInputBorder()
      ),
    style: TextStyle(color: Colors.grey),
    textAlign: TextAlign.center,
    onSubmitted: (text){
      setState(() {
        _search = text;
        _offSet = 0;
      });
    },
  );
  }

  Widget _buildLoading(){
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

  Widget _createGridGIF(BuildContext context, AsyncSnapshot snapshot){
    switch (snapshot.connectionState){
      case ConnectionState.waiting:
      case ConnectionState.none:
        return _buildLoading(); //Constrói a animação circular de espera.
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
            itemCount: _getCount(snapshot.data["data"]),
            itemBuilder: (context, index){
              if(_search == null || index < snapshot.data["data"].length)
                return GestureDetector(
                  child: Image.network(snapshot.data["data"][index]["images"]["fixed_height"]["url"],
                    height: 300,
                    fit: BoxFit.cover,
                    ),
                  onTap: (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GifPage(snapshot.data["data"][index]))
                    );
                  },
                );
              else
                return Container(
                  child: GestureDetector(
                    child: _buildPlus(),//Botão de carregar para carregar mais Gifs.
                    onTap: (){
                      setState(() {
                       _offSet += 19; 
                      });
                    },
                  ),
                );
            }
          );
    }
  }

  Widget _buildPlus(){
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.add, color: Colors.pink, size: 50),
              Text("Mais...", style: TextStyle(color: Colors.pink, fontSize: 18),)
            ],
    );
  }
}