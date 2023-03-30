import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../constant/api_consts.dart';


class ApiService{
  static Future <void> getModels() async {

    try{
     var response = await http.get(Uri.parse("$BASE_URL/models"),
      headers:{
        'Authorization': 'Bearer $API_KEY'});


      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse ['error'] != null){
        throw HttpException(jsonResponse['error']['message']);
      }
      print("jsonResponse $jsonResponse");
    } catch(error) {
      print("error $error");
    }


  }
}