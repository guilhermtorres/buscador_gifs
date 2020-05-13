import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GifPage extends StatelessWidget {
  final Map gifData;

  GifPage(this.gifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: Icon(
                  Icons.share,
                ),
                onPressed: () {
                  Share.share(
                    gifData['images']['fixed_height']['url'],
                  );
                }),
          )
        ],
        title: Row(
          children: <Widget>[
            Container(
              height: 40,
              width: 200,
              child: FittedBox(
                child: Text(
                  gifData['title'],
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Image.network(
          gifData['images']['fixed_height']['url'],
        ),
      ),
    );
  }
}
