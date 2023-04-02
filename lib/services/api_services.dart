import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:chatgpt/models/models_model.dart';
import 'package:http/http.dart' as http;

import '../constant/api_consts.dart';


class ApiService{
  static Future <List<ModelsModel>> getModels() async {

    try{
     var response = await http.get(Uri.parse("$BASE_URL/models"),
      headers:{
        'Authorization': 'Bearer $API_KEY'});


      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse ['error'] != null){
        throw HttpException(jsonResponse['error']['message']);
      }
      print("jsonResponse $jsonResponse");

      List temp =[];
      for (var value in jsonResponse['data']){
        //print(value["id"]);
        temp.add(value);
        log("temp ${value["id"]}");
  
        //print(1.toString());
        
        }


      return  ModelsModel.modelsFromSnapshot(temp);
    } catch(error) {
      
      log("temp_error $error");
      rethrow;
    }


  }
}