import 'package:ecommerce_app/ui/login_page.dart';
import 'package:ecommerce_app/ui/register_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xff3d155f),
        accentColor: Color(0xffdf678c),
        cursorColor: Colors.black,
        textTheme: TextTheme(
          headline: TextStyle( fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle( fontSize: 36.0, fontStyle: FontStyle.normal),
          body1: TextStyle( fontSize: 18.0)
        )
      ),
      routes: {
        '/login' : (BuildContext context) => LoginPage(),
        '/register' : (BuildContext context) => RegisterPage()
      },
      home: LoginPage(),
    );
  }
}

