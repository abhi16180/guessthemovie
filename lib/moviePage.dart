import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import './titlePage.dart';
import './main.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

String movieTitle = '';
String moviePlot = '';
var randomIndex;
List<String> hiddenTitle = [""];

int rnd() {
  var r = Random();
  return 0 + r.nextInt(250 - 0);
}

Future fetchTitle() async {
  var URL = Uri.parse(url);
  var response = await http.get(URL);
  var title = convert.jsonDecode(response.body) as Map<dynamic, dynamic>;
  randomIndex = rnd();
  movieTitle = title["Movies"][randomIndex]["Title"].toString().toLowerCase();
  moviePlot = title["Movies"][randomIndex]["Plot"].toString();
  hidetext(movieTitle);
}

void hidetext(String mvTitle) {
  hiddenTitle = mvTitle.split('');
  for (int i = 0; i < hiddenTitle.length; i++) {
    if (mvTitle[i] != ' ') {
      hiddenTitle[i] = "*";
    }
  }
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchTitle(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.done) {
          return TitlePage(
            title: hiddenTitle.join().toString(),
          );
        } else
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.yellow[600],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: randomIndex % 2 == 0
                      ? Text(
                          'This question is tricky...',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        )
                      : Text(
                          'Finding you an easy question...',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                ),
              ],
            ),
          );
      },
    );
  }
}
