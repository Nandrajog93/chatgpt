import 'package:chatgpt/constant/constant.dart';
import 'package:chatgpt/provider/model_provider.dart';
//import 'package:chatgpt/provider/model_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../constant/text_widget.dart';
import '../models/models_model.dart';
import '../provider/model_provider.dart';
//import '../provider/model_provider.dart';
import '../services/api_services.dart';

class DropDown extends StatefulWidget {
  const DropDown({super.key});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String ?currentModel;
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context,listen: false);
    currentModel = modelsProvider.getcurrentModel; /// This is to select the drowndown and remain the text.
      return FutureBuilder<List<ModelsModel>>(
        
        future: ApiService.getModels(),
        builder: (context,snapshot){
          if (snapshot.hasError){
              return Center(
                //int.parse(snapshot.data.data['totalPg'].toString());
                child: TextWidget(label:snapshot.error.toString()),
                );
          }
         return snapshot.data  == null || snapshot.data!.isEmpty 
         ? const SizedBox.shrink() 
         :  FittedBox(
           child: DropdownButton(
                 dropdownColor: scaffoldBackgroundColor,
                 iconEnabledColor: Colors.white,
               items: List<DropdownMenuItem<String>>.generate(snapshot.data!.length, 
               
           (index) => DropdownMenuItem(
             value:snapshot.data![index].id,
             
             child: TextWidget(
             label: snapshot.data![index].id,
             fontSize: 15, ))),
               value: currentModel,  /// This is to select the drowndown and remain the text.
               onChanged: (value) => {setState(() {
                 currentModel =value.toString();
               }),
               modelsProvider.setCurrentModel(value.toString()) /// This is to select the drowndown and remain the text.

               },
               ),
         );

        });
  }
}

