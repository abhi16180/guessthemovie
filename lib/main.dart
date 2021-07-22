import 'package:flutter/material.dart';
import 'package:guessthemovie/moviePage.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Questrial',
      ),
      routes: {
        'home': (context) => Home(),
      },
      home: AnimatedSplashScreen(
        splash: Text(
          'MOVIE GUESSER',
          style: TextStyle(fontSize: 40, fontFamily: 'Questrial'),
        ),
        animationDuration: Duration(milliseconds: 600),
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: Home(),
      ),
    ),
  );
}

List<String> types = [
  "Top 250 movies",
  "Top 250 English movies",
  "Top 250 Indian movies",
];
String url = '';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movie Guesser',
          style: TextStyle(
            fontFamily: 'Questrial',
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage('asset/images/moviesPoster.jpg'),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 250),
              child: Container(
                width: 400,
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, item) {
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        height: 50,
                        width: 180,
                        child: InkWell(
                          child: Center(
                            child: Text(
                              types[item],
                              style: TextStyle(fontFamily: 'Questrial'),
                            ),
                          ),
                          onTap: () {
                            switch (item) {
                              case 0:
                                setState(() {
                                  url =
                                      'https://api.npoint.io/c8bb8492ccb141c867d4';
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MoviePage();
                                    },
                                  ),
                                );
                                break;
                              case 1:
                                setState(() {
                                  url =
                                      'https://api.npoint.io/b4ecba425e22389c9fac';
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MoviePage();
                                    },
                                  ),
                                );
                                break;
                              case 2:
                                setState(() {
                                  url =
                                      'https://api.npoint.io/86f8103ee9438dbc7a2f';
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MoviePage();
                                    },
                                  ),
                                );
                                break;
                              default:
                                break;
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
