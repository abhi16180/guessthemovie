import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

String txt = '', responsetext = 'hey';
int i = 10;
int rnd() {
  var rand = new Random();
  var i = 0 + rand.nextInt(250 - 0);
  print(i);
  return i;
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    void _fetch() async {
      var url = Uri.parse(
          'https://data-imdb1.p.rapidapi.com/movie/order/byRating/?format=json&rapidapi-key=9b70c942efmsha9370d8681f7192p1cb870jsnc7001a636abc');

      var resp = await http.get(url);
      if (resp.statusCode == 200) {
        var jsonresp = convert.jsonDecode(resp.body) as Map<String, dynamic>;
        responsetext =
            (jsonresp["Movie Order By Rating"][0]["title"]).toString();
        print(responsetext);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Guess the movie '),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan, Colors.purple],
            ),
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: RichText(
            text: TextSpan(
                text: "Press the below button\nMOVIE name will appear\n",
                children: [
                  TextSpan(
                    text: '$responsetext',
                  )
                ]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _fetch();
            txt = responsetext;
            i++;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
