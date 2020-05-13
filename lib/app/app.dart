import 'package:buscador_gifs/app/src/views/home_views.dart';
import 'package:flutter/material.dart';

class BuscadorGifsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeView(),
      theme: ThemeData(
        cursorColor: Colors.amber,
        buttonColor: Colors.amber,
        indicatorColor: Colors.amber,
        accentColor: Colors.amber,
        hintColor: Colors.amber,
        primarySwatch: Colors.amber,
        primaryColor: Colors.amber,
        fontFamily: 'Rokkitt',
        canvasColor: Colors.black,
        textTheme: TextTheme(
          body1: TextStyle(
            fontFamily: 'Rokkitt',
            color: Colors.white,
            fontSize: 24,
          ),
          title: TextStyle(
            fontFamily: 'PermanentMarker',
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        appBarTheme: AppBarTheme(
          elevation: 5,
          color: Colors.black,
          iconTheme: IconThemeData(color: Colors.amber),
          textTheme: TextTheme(
            title: TextStyle(
              fontFamily: 'PermanentMarker',
              color: Colors.white,
              letterSpacing: 3,
            ),
          ),
        ),
      ),
    );
  }
}
