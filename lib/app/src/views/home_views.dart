import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Buscador de Gifs",
        ),
      ),
      body: Center(
        child: Text(
          'App de gifs!',
        ),
      ),
    );
  }
}
