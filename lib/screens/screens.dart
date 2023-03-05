import 'package:chatgpt/services/assets_manager.dart';
import 'package:chatgpt/widgets/chat_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constant/constant.dart';



class ChatSceen extends StatefulWidget {
  const ChatSceen({super.key});
  
  @override
  State<ChatSceen> createState() => _ChatSceenState();
}

class _ChatSceenState extends State<ChatSceen> {
  final bool _istyping = true;

  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text("ChatGPT"),
        actions: [
          IconButton(
            onPressed: (){}, icon: Icon(Icons.more_vert_rounded, color: Colors.white,))
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
              itemCount: 6,
              itemBuilder: (context,index){
                return   ChatWidget(
                  msg: chatMessages[index]['msg'].toString(),
                  chatIndex: int.parse(
                    chatMessages[index]['chatIndex'].toString()),
                );
              }),
        ),
        if (_istyping) ...[

            const SpinKitThreeBounce(
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(height: 15,),
            Material(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children:  [
                  Expanded(
                    child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: textEditingController,
                    onSubmitted:(value){
                       
                          
                      
                    },
                    decoration: const InputDecoration.collapsed(hintText: "How can I help you",
                     hintStyle: TextStyle(color: Colors.grey) ),
                  ),
                  ),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.send, color: Colors.white,))
                  
                ]
                ),
              ),
            )
        ]
        ],
        )
        ),
    );
  } 
}