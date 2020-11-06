import 'package:appcomida/Carrinho/carrinho_page.dart';
import 'package:appcomida/Home/home_page.dart';
import 'package:appcomida/Login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Comida',
      routes: {
        CarrinhoPage.routeName: (context) => CarrinhoPage(),
        LoginPage.routeName: (context) => LoginPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
