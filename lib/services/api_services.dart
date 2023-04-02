import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:chatgpt/models/models_model.dart';
import 'package:http/http.dart' as http;

import '../constant/api_consts.dart';
import '../models/chart_model.dart';


class ApiService{
  static Future <List<ModelsModel>> getModels() async {

    try{
     var response = await http.get(Uri.parse("$BASE_URL/models"),
      headers:{
        //'Authorization': 'Bearer $API_KEY'});
       'Authorization': 'Bearer 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'});


      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse ['error'] != null){
        throw HttpException(jsonResponse['error']['message']);
      }
      print("jsonResponse $jsonResponse");

      List temp =[];
      for (var value in jsonResponse['data']){
        
       // print(value);
        temp.add(value);
        log("temp ${value["id"]}");

        }


      return  ModelsModel.modelsFromSnapshot(temp);
    } catch(error) {
  
      log("temp_error $error");
      rethrow;
    }


  }


// Send Message fct
  static Future<List<ChatModel>> sendMessage({required String message, required  String modelId}) async {

    try{
     var response = await http.post(
        Uri.parse("$BASE_URL/completions"),
      headers:{
        //'Authorization': 'Bearer $API_KEY'});
       'Authorization': 'Bearer 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',
       "Content-Type": "application/json"},
       body: jsonEncode({"model": modelId,
       "prompt": message,
       "max_tokens": 100,
       "temperature": 0}));


      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse ['error'] != null){
        throw HttpException(jsonResponse['error']['message']); // This IF is here to take care of a ERROR
      }
/// This measn we definatley has a length 
/// 
List<ChatModel> chatList =[];
      if (jsonResponse["choices"].length >0){
        //log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
        //log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");

//[0] for the index
chatList = List.generate(jsonResponse['choices'].length, (index) => ChatModel(
        msg: jsonResponse["choices"][index]["text"], 
        chatIndex: 1),
        ); 
      }
      return chatList;

    } catch(error) {
  
      log("temp_error $error");
      rethrow;
    }


  }
}