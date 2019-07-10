import 'dart:convert';
import 'package:http/http.dart' as http;

String _search;
int _offSet = 0;

final String urlTrend = "https://api.giphy.com/v1/gifs/trending?api_key=L1yPbYOU9AcWGzIMsTYP10Dn6hK67Z6Z&limit=20&rating=G";
final String urlSearch = "https://api.giphy.com/v1/gifs/search?api_key=L1yPbYOU9AcWGzIMsTYP10Dn6hK67Z6Z&q=$_search&limit=$_offSet&offset=40&rating=G&lang=en";

getGIF() async {
  http.Response response;

  if(_search == null)
    response = await http.get(urlTrend);
  else
    response = await http.get(urlSearch);

  return json.decode(response.body);
}


