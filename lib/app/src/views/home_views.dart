import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

import 'gif_page_views.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String search;
  int offSet = 0;
  Future<Map> getGifs() async {
    http.Response response;

    if (search == null || search.isEmpty)
      response = await http.get(
        'https://api.giphy.com/v1/gifs/trending?api_key=5fUcvXwDG1ZuBwvaM0Pt4XH6Zpecyo4G&limit=20&rating=G',
      );
    else
      response = await http.get(
        'https://api.giphy.com/v1/gifs/search?api_key=5fUcvXwDG1ZuBwvaM0Pt4XH6Zpecyo4G&q=$search&limit=19&offset=$offSet&rating=G&lang=en',
      );
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/bolanotica.gif',
              height: 40,
              width: 40,
              alignment: AlignmentDirectional.bottomStart,
            ),
            Text(
              " Buscador de Gif\'s",
              style: TextStyle(
                fontSize: 26,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              onSubmitted: (text) {
                setState(() {
                  search = text;
                  offSet = 0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Quais gif\'s você procura??',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              style: TextStyle(color: Colors.white, fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getGifs(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5,
                      ),
                    );
                  default:
                    if (snapshot.hasError)
                      return Container();
                    else
                      return createGifTable(context, snapshot);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  int getCount(List data) {
    if (search == null) {
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  Widget createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: getCount(snapshot.data['data']),
      itemBuilder: (context, index) {
        if (search == null || index < snapshot.data['data'].length)
          return GestureDetector(
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: snapshot.data['data'][index]['images']['fixed_height']['url'],
              height: 300,
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GifPage(
                    snapshot.data['data'][index],
                  ),
                ),
              );
            },
            onLongPress: () {
              Share.share(
                snapshot.data['data'][index]['images']['fixed_height']['url'],
              );
            },
          );
        else
          return Container(
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 70,
                  ),
                  Text(
                    'Mais Gif\'s...',
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  offSet += 19;
                });
              },
            ),
          );
      },
    );
  }
}
