import 'package:chatgpt/provider/chats_provider.dart';
import 'package:chatgpt/provider/model_provider.dart';
import 'package:chatgpt/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constant/constant.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
       providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(
            color:cardColor),
        ),
        home: const ChatScreen(),
      ),
    );
  }
}


