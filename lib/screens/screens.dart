import 'dart:developer';

import 'package:chatgpt/constant/text_widget.dart';
import 'package:chatgpt/services/assets_manager.dart';
import 'package:chatgpt/widgets/chat_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../constant/constant.dart';
import '../models/chart_model.dart';
import '../provider/model_provider.dart';
import '../services/api_services.dart';
import '../services/services.dart';



class ChatSceen extends StatefulWidget {
  const ChatSceen({super.key});
  
  @override
  State<ChatSceen> createState() => _ChatSceenState();
}

class _ChatSceenState extends State<ChatSceen> {
  bool _istyping = false;

  late TextEditingController textEditingController;
  late FocusNode focusNode;

  @override
  void initState() {
    textEditingController = TextEditingController();
    focusNode =FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  List<ChatModel> chatList =[];
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    return Scaffold(
      appBar:  AppBar(
        title: const Text("ChatGPT"),
        actions: [
          IconButton(
            onPressed: () async{
                await Services.showModalSheet(context: context);
                

            }, 
            icon: Icon(Icons.more_vert_rounded, color: Colors.white))
        ],
        elevation: 10,
        leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(AssetsManager.openaiLogo),
      ),),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(child: 
            ListView.builder(
              itemCount: chatList.length,
              itemBuilder: (context,index){
                return   ChatWidget(
                  msg: chatList[index].msg,
                  chatIndex: 
                    chatList[index].chatIndex,
                );
              }),
        ),
        if (_istyping) ...[

            const SpinKitThreeBounce(
              color: Colors.white,
              size: 18,
            ),
            ],
            const SizedBox(height: 15,),
            Material(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children:  [
                  Expanded(
                    child: TextField(
                      focusNode: FocusNode(),
                    style: const TextStyle(color: Colors.white),
                    controller: textEditingController,
                    onSubmitted:(value)
                       async{
                    await sendMesssageFCT(modelsProvider: modelsProvider); /// This is when user send a message
                  

                          
                      
                    },
                    decoration: const InputDecoration.collapsed(hintText: "How can I help you",
                     hintStyle: TextStyle(color: Colors.grey) ),
                  ),
                  ),
                  IconButton(onPressed: ()async{
                    await sendMesssageFCT(modelsProvider: modelsProvider);
                  },

                  icon: const Icon(Icons.send, color: Colors.white,))
                  
                ]
                ),
              ),
            )
        
        ],
        )
        ),
    );
  } 
  Future<void> sendMesssageFCT ({required ModelsProvider modelsProvider})                   
            async{
                    try {
                      setState(() {
                        _istyping = true; 
                        chatList.add(ChatModel(msg: textEditingController.text
                        , chatIndex: 0));
                        textEditingController.clear();
                        focusNode.unfocus();
                      });
                  chatList.addAll( await ApiService.sendMessage(
                    message: textEditingController.text,
                    modelId: modelsProvider.getcurrentModel));

                    setState(() {
                      
                    });
                    } catch(error){
                        log("error $error");
                    } finally  {setState(() {
                        _istyping = true; 
                      });
                      }
                  }
}