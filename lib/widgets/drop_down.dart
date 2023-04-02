import 'package:chatgpt/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../constant/text_widget.dart';
import '../models/models_model.dart';
import '../services/api_services.dart';

class DropDown extends StatefulWidget {
  const DropDown({super.key});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String currentModel ="text-davinci-003";
  @override
  Widget build(BuildContext context) {
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
               value: currentModel,
               onChanged: (value) => {setState(() {
                 currentModel =value.toString();
               })
               },
               ),
         );

        });
  }
}

