import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiService {

  // to fetch songs form the external open database uisng api key
  // api service mein pehele we need an api we use convert

  Future<List<dynamic>> fetchSong(String querry ) async{

  // when i get url from the exernal url for fetching the songs enter it here :
  final url = 'https://api.deezer.com/search?q=${querry}';
  final response = await http.get(Uri.parse(url));

  if(response.statusCode == 200){
    // response body : response.body will contain a list of maps each individual map contains a song
    final data = jsonDecode(response.body)['data'];
    return data;
  }

  else{
   return [];
  }

  }


  // now for fetchng top global songs for homescreen

  Future<List<dynamic>> fetchTopGlobalSong() async{

  final url = 'https://api.deezer.com/chart/0/tracks';
  final response = await http.get(Uri.parse(url));

  if(response.statusCode == 200){
    final data = jsonDecode(response.body)['data'];
    return data;

  }

  else{
    return [];
  }

  }



  // now for fetching top indian songs

  Future<List<dynamic>> fetchTopIndianSong() async{
 
  // when i get url from the exernal url for fetching the songs enter it here :
  final url = 'https://api.deezer.com/chart/IN/tracks';
  final response = await http.get(Uri.parse(url));

  if(response.statusCode == 200){
    final data = jsonDecode(response.body)['data'];
    return data;

  }

  else{
    return [];
  }

  }
}

