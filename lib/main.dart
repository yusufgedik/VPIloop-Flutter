  
//import 'dart:js';
import 'package:Iloop/Utility/Utility.dart';
import 'package:Iloop/home/home-page.dart';
import 'package:Iloop/services/services.dart';
import 'package:flutter/material.dart';
import 'package:Iloop/expense-create/expense-create-page.dart';
import 'package:Iloop/login/login-page.dart';
import 'package:get_it/get_it.dart';
void setupLocator() {
  GetIt.I.registerLazySingleton(() => IloopService());
  GetIt.I.registerLazySingleton(() => UtilityClass());
}
void main(){ 
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    ExpenseCreate.tag: (context) => ExpenseCreate(""),
    HomePage.tag: (context) => HomePage(""),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'İloop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}