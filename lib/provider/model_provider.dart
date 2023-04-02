import 'package:chatgpt/services/api_services.dart';
import 'package:flutter/material.dart';

import '../models/models_model.dart';

class ModelsProvider with ChangeNotifier{

  

    String currentModel = "text-davinci-003";
      String get getcurrentModel  {
      return currentModel;
      
    }
    void setCurrentModel(String newModel){
      currentModel = newModel;
      notifyListeners(); // TO LISTIN THIS IS MUST BE THE PARENT OF A MAIN WIDGET
    }
      List<ModelsModel> modellist =[];

      List<ModelsModel> get getModelsList  {
      return modellist;
      
    }
    Future <List<ModelsModel>> getALLModels() async{
      modellist = await ApiService.getModels();
      return modellist;
    }
}